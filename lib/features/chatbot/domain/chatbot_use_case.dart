import 'dart:convert';

import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/core/utils/misc.dart';
import 'package:chatbot/core/utils/shared_pref.dart';
import 'package:chatbot/core/utils/websocket_constants.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_entity.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/gateway/chatbot_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/configuration_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/conversation_history_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/init_guest_user_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/send_message_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/start_conversation_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_connect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_disconnect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_init_command_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_message_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_send_message_gateway.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/model/chat_assignee.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:chatbot/features/chatbot/model/survey_input.dart';
import 'package:chatbot/features/chatbot/model/websocket/init_command_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:chatbot/providers.dart';
import 'package:clean_framework/clean_framework.dart';

import 'transformers/input_transformers.dart';
import 'transformers/output_transformers.dart';

class ChatBotUseCase extends UseCase<ChatBotEntity> {
  ChatBotUseCase()
      : super(
          entity: const ChatBotEntity(),
          transformers: [
            ChatBotUIOutputTransformer(),
            ChatDetailsUIOutputTransformer(),
            ChatDetailsConnectMessageInputTransformer(),
            ChatDetailsGetMessageInputTransformer(),
            ChatDetailsSendMessageInputTransformer(),
            ChatDetailsDisconnectMessageInputTransformer(),
          ],
        );

  void initUserSession() {
    entity = entity.merge(
        chatBotUiState: ChatBotUiState.setupLoading,
        chatSessionState: ChatSessionState.sessionUnavailable);

    request(InitGuestUserGatewayOutput(),
        onSuccess: (InitGuestUserSuccessInput input) {
      preference
          .put(PreferenceKey.sessionId, input.initData.user.sessionId)
          .then((value) {
        // Assigning session Idle Time
        final clearSessionAfter =
            input.initData.app.inboundSettings.visitors.idleSessionsAfter;
        entity = entity.merge(
            idleTimeout: clearSessionAfter,
            chatSessionState: ChatSessionState.sessionActive);
        loadConfigurations();
        loadRecentConversationList(perPage: 100, page: 1);
        initialiseWebSocket();
      });

      return entity;
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
  }

  void loadConfigurations() {
    request(const ConfigurationGatewayOutput(),
        onSuccess: (SDKConfigurationSuccessInput input) {
      return entity.merge(
          outBondUiState: input.appSettings.app.inBusinessHours
              ? OutBondUiState.outBondStateOpen
              : OutBondUiState.outBondStateClose,
          appSettings: input.appSettings);
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
  }

  Future<void> clearSession() async {
    await preference.remove(PreferenceKey.sessionId);
    entity = entity.merge(chatList: []);
    initUserSession();
  }

  void loadRecentConversationList({int page = 1, int perPage = 100}) {
    entity = entity.merge(
        conversationsListUiState: ConversationsListUiState.loading);
    request(ChatBotGatewayOutput(page: page, perPage: perPage),
        onSuccess: (ChatBotSuccessInput input) {
      return entity.merge(
        chatList: input.chatList.conversations,
        conversationsListUiState: ConversationsListUiState.idle,
      );
    }, onFailure: (_) {
      return entity.merge(
        conversationsListUiState: ConversationsListUiState.idle,
        chatBotUiState: ChatBotUiState.conversationFailure,
      );
    });
  }

  void initializeNewConversation() {
    if (entity.chatTriggerId.isEmpty) {
      startNewConversation();
    } else {
      initWebsocketCommand(chatTriggerId: entity.chatTriggerId);
    }
  }

  //region chat conversation starts
  void startNewConversation() {
    entity = entity.merge(
      chatDetailsUiState: ChatDetailsUiState.loading,
      chatDetailList: [],
    );

    request(StartConversationGatewayOutput(),
        onSuccess: (StartConversationSuccessInput input) {
      entity =
          entity.merge(chatTriggerId: input.data.app.newConversationBots.id);
      initWebsocketCommand(chatTriggerId: entity.chatTriggerId);
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.success,
      );
    }, onFailure: (_) {
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.failure,
      );
    });
  }

  // region realtime data requests
  void initialiseWebSocket() {
    entity = entity.merge(
      chatBotUiState: ChatBotUiState.setupLoading,
      userInputOptions: [],
      chatDetailList: [],
    );

    request(WebsocketConnectGatewayOutput(),
        onSuccess: (WebsocketConnectSuccessInput input) {
      listenForMessages();
      return entity;
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
  }

  void listenForMessages() {
    request(WebsocketMessageGatewayOutput(),
        onSuccess: (WebsocketMessageSuccessInput input) {
      subscribeToPresenceChannel();
      subscribeToMessengerChannel();
      return entity;
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
  }

  void sendMessage(
      {required String messageData, required ChatMessageType messageType}) {
    if (messageType == ChatMessageType.enterMessage) {
      request(
          SendMessageGatewayOutput(
              conversationId: entity.conversationKey,
              appKey: providersContext().read(envReaderProvider).getAppID(),
              message: {
                "html": messageData,
                "text": messageData,
                "serialized": serializedContent(messageData),
              }), onSuccess: (SendMessageSuccessInput input) {
        return entity;
      }, onFailure: (_) {
        return entity;
      });
    } else {
      entity = entity.merge(
          chatBotUserState: ChatBotUserState.idle,
          chatMessageType: ChatMessageType.idle);
      final messageuiData = MessageUiModel(
        message: messageData,
        messageId: DateTime.now().toString(),
        messageSenderType: MessageSenderType.user,
        createdAt: DateTime.now().toString(),
      );
      entity = entity.merge(
          chatBotUserState: ChatBotUserState.idle,
          chatMessageType: ChatMessageType.idle,
          chatDetailList: [messageuiData, ...entity.chatDetailList]);
      request(
          WebsocketInitCommandGatewayOutput(
              messageToSend:
                  getNextMessageAfterUserInputCommandData(messageData)),
          onSuccess: (WebsocketSendMessageSuccessInput input) {
        return entity;
      }, onFailure: (_) {
        return entity;
      });
    }
  }

  String serializedContent(String message) {
    return "{\"blocks\":[{\"key\":\"${getRandomKey(length: 5)}\",\"text\":\"$message\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}";
  }

  void disconnectMessageChannel() {
    request(WebsocketDisconnectGatewayOutput(),
        onSuccess: (WebsocketDisconnectSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity;
    });
  }

  void initWebsocketCommand({required String chatTriggerId}) {
    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend:
                getInitWebsocketCommandData(chatTriggerId: chatTriggerId)),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.success,
      );
    }, onFailure: (_) {
      return entity;
    });
  }

  //If there is no previous conversations, then start a trigger
  void initWebsocketConversation() {
    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend: getInitSendMessageChannel()),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      sendTriggerInitiateMessage();
      return entity;
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
  }

  void sendTriggerInitiateMessage() {
    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend: getEngageAppUserChannel()),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      dismissProgressAfterTwoSeconds();
      return entity;
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
  }

  void dismissProgressAfterTwoSeconds() {
    Future.delayed(const Duration(milliseconds: 2300), () {
      entity = entity.merge(
        chatBotUiState: ChatBotUiState.setupSuccess,
      );
    });
  }

  InitCommandModel getInitWebsocketCommandData(
      {required String chatTriggerId}) {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketMessage,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: jsonEncode(Data(
        action: socketActionTrigger,
        conversation: null,
        trigger: chatTriggerId,
      ).toJson()),
    );
  }

  InitCommandModel getInitSubscribePresenceChannel() {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketSubscribe,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketPresenceChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: null,
    );
  }

  InitCommandModel getInitSubscribeMessengerChannel() {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketSubscribe,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: null,
    );
  }

  InitCommandModel getInitSendMessageChannel() {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketMessage,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: jsonEncode(const Data(
        action: socketActionSendMessage,
        conversation: null,
        trigger: null,
        title: "Mobile SDK",
        url: "",
        browserName: "",
        browserVersion: "",
        os: "",
        osVersion: "",
      ).toJson()),
    );
  }

  InitCommandModel getInitUserBannersChannel() {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketMessage,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: jsonEncode(const Data(
        action: socketGetBannersForUser,
        conversation: null,
        trigger: null,
      ).toJson()),
    );
  }

  InitCommandModel getEngageAppUserChannel() {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketMessage,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: jsonEncode(const Data(
        action: socketEngageAppUser,
        conversation: null,
        trigger: null,
      ).toJson()),
    );
  }

  void subscribeToPresenceChannel() {
    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend: getInitSubscribePresenceChannel()),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
  }

  void subscribeToMessengerChannel() {
    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend: getInitSubscribeMessengerChannel()),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
  }

  void getNextConversationMessage(
      {required String conversationKey, required String messageKey}) {
    Future.delayed(const Duration(milliseconds: 300), () {
      request(
          WebsocketInitCommandGatewayOutput(
              messageToSend: getNextConversationCommandData(
            conversationKey: conversationKey,
            messageKey: messageKey,
          )), onSuccess: (WebsocketSendMessageSuccessInput input) {
        return entity;
      }, onFailure: (_) {
        return entity;
      });
    });
  }

  InitCommandModel getNextConversationCommandData(
      {required String conversationKey, required String messageKey}) {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketMessage,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: jsonEncode(Data(
        action: socketActionReceiveConversation,
        conversation: null,
        trigger: null,
        conversationKey: conversationKey,
        messageKey: messageKey,
      ).toJson()),
    );
  }

  InitCommandModel getNextMessageAfterUserInputCommandData(String message) {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketMessage,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: jsonEncode(Data(
          action: socketActionReceiveConversation,
          conversation: null,
          conversationKey: entity.conversationKey,
          messageKey: entity.messageKey,
          trigger: entity.chatTriggerId,
          step: entity.chatStepId,
          replyInput: BlockInput(
            pathId: entity.chatPathId,
            nextStepUuid: entity.chatNextStepUUID,
            label: "wait_for_reply",
            htmlContent: message,
            serializedContent: serializedContent(message),
            textContent: message,
          )).toJson()),
    );
  }

  void sendUserInput({required Block inputData}) {
    entity = entity.merge(
        chatBotUserState: ChatBotUserState.idle,
        chatMessageType: ChatMessageType.idle);
    final messageuiData = MessageUiModel(
      message: "$sentMessageHead${inputData.label}",
      messageId: DateTime.now().toString(),
      messageSenderType: MessageSenderType.user,
      createdAt: DateTime.now().toString(),
    );
    entity = entity.merge(
        chatBotUserState: ChatBotUserState.idle,
        chatMessageType: ChatMessageType.idle,
        chatDetailList: [messageuiData, ...entity.chatDetailList]);
    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend: setUserInputCommand(inputData)),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity;
    });
  }

  InitCommandModel setUserInputCommand(Block inputData) {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketMessage,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: jsonEncode(Data(
        action: socketActionTriggerStep,
        conversation: null,
        trigger: entity.chatTriggerId,
        conversationKey: entity.conversationKey,
        messageKey: entity.messageKey,
        reply: inputData,
        pathId: inputData.pathId,
        step: inputData.nextStepUuid,
      ).toJson()),
    );
  }

  void loadMoreChats() {
    if (entity.chatDetailList.isEmpty ||
        entity.chatListUiState == ChatListUiState.loading) {
      return;
    }
    entity = entity.merge(chatListUiState: ChatListUiState.loading);
    loadChatHistory(
      conversationID: entity.conversationKey,
      currentPage: entity.currentPage + 1,
    );
  }

  void loadChatHistory({required String conversationID, int currentPage = 1}) {
    if (currentPage == 1) {
      entity = entity.merge(
        chatDetailsUiState: ChatDetailsUiState.loading,
        chatDetailList: [],
      );
    }
    request(
        ConversationHistoryGatewayOutput(
          page: currentPage,
          conversationID: conversationID,
        ), onSuccess: (ConversationHistorySuccessInput input) {
      parseConversationHistory(input.data, conversationID);
      return entity.merge(
          chatDetailsUiState: ChatDetailsUiState.success,
          chatListUiState: ChatListUiState.idle);
    }, onFailure: (_) {
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.failure,
        chatListUiState: ChatListUiState.idle,
      );
    });
  }
  InitCommandModel setUserInputCommandAsMap(Map inputData) {
    final sessionId = preference.get<String>(PreferenceKey.sessionId, "");
    return InitCommandModel(
      command: socketMessage,
      identifier: jsonEncode(Identifier(
              app: providersContext().read(envReaderProvider).getAppID(),
              channel: socketMessageChannel,
              sessionId: sessionId ?? "",
              encData: "{}",
              sessionValue: null,
              userData: "{}")
          .toJson()),
      data: jsonEncode({
        'data': inputData,
        'conversation_key': entity.conversationKey,
        'message_key': entity.messageKey,
        'action': socketActionSubmit,
      }),
    );
  }


  void parseConversationHistory(
      Map<String, dynamic> data, String conversationID) {
    final List<dynamic> conversationList =
        data["messenger"]["conversation"]["messages"]["collection"];
    final assigneeMap = data["messenger"]["conversation"]['assignee'];
    final assignee = ChatAssignee.fromJson(assigneeMap);
    final curPage =
        data["messenger"]["conversation"]["messages"]["meta"]["current_page"];
    final totalPages =
        data["messenger"]["conversation"]["messages"]["meta"]["total_pages"];
    entity = entity.merge(
        chatAssignee: assignee, currentPage: curPage, totalPages: totalPages);

    final itemList =
        curPage == 1 ? conversationList.reversed : conversationList;

    for (dynamic item in itemList) {
      parseHistoryMessage(item, conversationID, curPage);
    }
    if (curPage == 1) {
      final lastItem = itemList.last;
      if ((lastItem["message"] as Map).containsKey("textContent") &&
          (lastItem["message"] as Map)["textContent"] != "--***--" &&
          (lastItem["message"] as Map)["textContent"] != null &&
          (lastItem["message"] as Map)["textContent"] != "") {
        entity = entity.merge(
            chatBotUserState: ChatBotUserState.waitForInput,
            chatMessageType: ChatMessageType.enterMessage);
      }
    }
    // Handle if the thread is closed

    if (data["messenger"]["conversation"]['state'] == 'closed') {
      entity = entity.merge(
        chatBotUserState: ChatBotUserState.conversationClosed,
      );
    }
  }

  void parseHistoryMessage(
      Map<String, dynamic> data, String conversationID, int curPage) {
    final conversationKey = conversationID;
    final messageKey = data["key"];
    entity = entity.merge(
      chatTriggerId: data["triggerId"],
      chatStepId: data["step_id"],
    );
    Map<String, dynamic> messageData = data["message"];
    var message = "";

    if (messageData.containsKey("blocks") && messageData["blocks"] != null) {
      MessageUiModel messageBlockLabel;
      final bool hasReplied =
          (messageData["state"] != null && messageData["state"] == "replied");
      final blockData = BlocksData.fromJson(messageData["blocks"]);
      if (blockData.label != null && blockData.label!.isNotEmpty) {
        messageBlockLabel = MessageUiModel(
          message: blockData.label!,
          messageId: messageData["id"].toString(),
          messageSenderType: data["appUser"]['kind'] == 'agent'
              ? MessageSenderType.bot
              : MessageSenderType.user,
          imageUrl: data["appUser"]["avatarUrl"],
          createdAt: data["createdAt"],
        );
        if (!entity.chatDetailList.contains(messageBlockLabel)) {
          if (curPage == 1 || (curPage != 1 && !hasReplied)) {
            entity = entity.merge(
                conversationKey: conversationKey,
                messageKey: messageKey,
                chatDetailList: curPage == 1
                    ? [
                        messageBlockLabel,
                        ...entity.chatDetailList,
                      ]
                    : [
                        ...entity.chatDetailList,
                        messageBlockLabel,
                      ]);
          }
        }
      }
      if (curPage == 1 && blockData.waitForInput) {
        entity = entity.merge(
          conversationKey: conversationKey,
          messageKey: messageKey,
          userInputOptions: blockData.schema,
          chatBotUserState: ChatBotUserState.waitForInput,
          chatMessageType: blockData.waitForReply
              ? ChatMessageType.enterMessage
              : ChatMessageType.askForInputButton,
        );
      }
      //Handle for Server Input

      if (messageData.containsKey("blocks") &&
          messageData["blocks"] != null &&
          messageData["blocks"]['type'] == 'app_package' &&
          messageData["blocks"]['app_package'] == 'Surveys') {
        String? sessionId = preference.get<String>(PreferenceKey.sessionId, "");
        final appId = providersContext().read(envReaderProvider).getAppID();

        entity = entity.merge(
          chatDetailList: curPage == 1
              ? [
                  SurveyMessage.fromJson(
                    messageData["blocks"]['schema'],
                    messageKey: messageKey,
                    conversationKey: conversationKey,
                    appId: appId,
                    sessionId: sessionId,
                  ),
                  ...entity.chatDetailList,
                ]
              : [
                  ...entity.chatDetailList,
                  SurveyMessage.fromJson(
                    messageData["blocks"]['schema'],
                    messageKey: messageKey,
                    conversationKey: conversationKey,
                    appId: appId,
                    sessionId: sessionId,
                  ),
                ],
          chatMessageType: curPage == 1 ? ChatMessageType.survey : null,
          chatBotUserState: curPage == 1 ? ChatBotUserState.survey : null,
        );
      }



      if (messageData["state"] != null && messageData["state"] == "replied") {
        if (blockData.askForInput &&
            messageData["data"] != null &&
            messageData["data"]["label"] != null) {
          final messageuiData = MessageUiModel(
            message: "$sentMessageHead${messageData["data"]["label"]}",
            messageId: DateTime.now().toString(),
            messageSenderType: MessageSenderType.user,
          );
          entity = entity.merge(
              chatDetailList: curPage == 1
                  ? [
                      messageuiData,
                      ...entity.chatDetailList,
                    ]
                  : [
                      ...entity.chatDetailList,
                      messageuiData,
                    ]);
        } else if (blockData.waitForReply &&
            messageData["data"] != null &&
            messageData["data"]["text_content"] != null) {
          final messageuiData = MessageUiModel(
            message: "$sentMessageHead${messageData["data"]["text_content"]}",
            messageId: DateTime.now().toString(),
            messageSenderType: MessageSenderType.user,
          );
          entity = entity.merge(
              chatDetailList: curPage == 1
                  ? [
                      messageuiData,
                      ...entity.chatDetailList,
                    ]
                  : [
                      ...entity.chatDetailList,
                      messageuiData,
                    ]);
        }
        messageBlockLabel = MessageUiModel(
          message: blockData.label!,
          messageId: messageData["id"].toString(),
          messageSenderType: MessageSenderType.bot,
          imageUrl: data["appUser"]["avatarUrl"],
          createdAt: data["createdAt"],
        );

        if (blockData.label != null &&
            blockData.label!.isNotEmpty &&
            curPage != 1 &&
            hasReplied &&
            !entity.chatDetailList.contains(messageBlockLabel)) {
          entity = entity.merge(
              conversationKey: conversationKey,
              messageKey: messageKey,
              chatDetailList: [
                ...entity.chatDetailList,
                messageBlockLabel,
              ]);
        }
      } else if (blockData.waitForReply) {
        entity = entity.merge(
          conversationKey: conversationKey,
          messageKey: messageKey,
          chatBotUserState: ChatBotUserState.waitForInput,
          chatMessageType: ChatMessageType.enterMessageAndTrigger,
          chatNextStepUUID: messageData["next_step_uuid"],
          chatPathId: messageData["path_id"],
        );
      }
    } else {
      if (messageData["htmlContent"] != null &&
          messageData["htmlContent"] != "--***--") {
        message = messageData["htmlContent"];
      } else if (messageData["serializedContent"] != null &&
          messageData["serializedContent"] != "--***--") {
        message = messageData["serializedContent"];
      } else if (messageData["textContent"] != null &&
          messageData["textContent"] != "--***--") {
        message = messageData["textContent"];
      } else if (messageData.containsKey("action") &&
          messageData["action"] == "assigned" &&
          curPage == 1) {
        message = "Assigned to ${messageData["data"]["name"]}";
        entity = entity.merge(
            chatBotUserState: ChatBotUserState.waitForInput,
            chatMessageType: ChatMessageType.enterMessage);
      }
      final messageuiData = MessageUiModel(
        message: message,
        messageId: messageKey,
        messageSenderType: data["appUser"]['kind'] == 'agent'
            ? MessageSenderType.bot
            : MessageSenderType.user,
        imageUrl: data["appUser"]["avatarUrl"],
        createdAt: data["createdAt"],
      );
      if (!entity.chatDetailList.contains(messageuiData)) {
        entity = entity.merge(
            conversationKey: conversationKey,
            messageKey: messageKey,
            chatDetailList: curPage == 1
                ? [
                    messageuiData,
                    ...entity.chatDetailList,
                  ]
                : [
                    ...entity.chatDetailList,
                    messageuiData,
                  ]);
      }
      if (messageData['data'] != null &&
          (messageData['data'] as Map).containsKey('next_step_uuid') &&
          messageData['data']['next_step_uuid'] == null &&
          curPage == 1) {
        entity = entity.merge(
            chatBotUserState: ChatBotUserState.waitForInput,
            chatMessageType: ChatMessageType.enterMessage);
      }
    }
  }

  void resetData() {
    entity = entity.merge(
      chatDetailList: [],
      chatBotUserState: ChatBotUserState.idle,
      chatMessageType: ChatMessageType.idle,
      userInputOptions: [],
      chatTriggerId: "",
      chatBotUiState: ChatBotUiState.setupSuccess,
      chatAssignee: const ChatAssignee(assignee: "", assigneeImage: ""),
      chatStepId: "",
      chatPathId: "",
      chatNextStepUUID: "",
      isAgentTyping : false,
    );
    loadRecentConversationList();
  }

  void onSurveySubmitted(Map<dynamic, dynamic> input) {
    entity = entity.merge(
        chatBotUserState: ChatBotUserState.idle,
        chatMessageType: ChatMessageType.idle);

    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend: setUserInputCommandAsMap(input)),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity;
    });
  }

  void toggleAgentTypingStatus() {
    entity= entity.merge(isAgentTyping: true);
      Future.delayed(const Duration(milliseconds: 500), (){
        entity= entity.merge(isAgentTyping: false);
      });
  }

  void updateEntityAfterDelay({required conversationKey, required messageKey, required List<ChatMessage> chatDetailList}) {
    Future.delayed(const Duration(milliseconds: 500),(){
      entity = entity.merge(
          conversationKey: conversationKey,
          messageKey: messageKey,
          chatDetailList: chatDetailList,
      );
    });
  }

  void updateInputTypeAfterDelay({required conversationKey, required messageKey, required List<Block> userInputOptions, required ChatBotUserState chatBotUserState, required ChatMessageType chatMessageType}) {
    Future.delayed(const Duration(milliseconds: 500),(){
      entity = entity.merge(
        conversationKey: conversationKey,
        messageKey: messageKey,
        userInputOptions: userInputOptions,
        chatBotUserState: chatBotUserState,
        chatMessageType: chatMessageType,
      );
    });
  }
}

const sentMessageHead = '';
