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

  void sendMessage({required String messageData}) {
    request(
        SendMessageGatewayOutput(
            conversationId: entity.conversationKey,
            appKey: providersContext().read(envReaderProvider).getAppID(),
            message: {
              "html": messageData,
              "text": messageData,
              "serialized":
                  "{\"blocks\":[{\"key\":\"${getRandomKey(length: 5)}\",\"text\":\"$messageData\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}",
            }), onSuccess: (SendMessageSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity;
    });
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
    Future.delayed(const Duration(milliseconds: 250), () {
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
        chatDetailList: [...entity.chatDetailList, messageuiData]);
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

  void loadChatHistory({required String conversationID}) {
    entity = entity.merge(
      chatDetailsUiState: ChatDetailsUiState.loading,
      chatDetailList: [],
    );

    request(
        ConversationHistoryGatewayOutput(
          conversationID: conversationID,
        ), onSuccess: (ConversationHistorySuccessInput input) {
      parseConversationHistory(input.data, conversationID);
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.success,
      );
    }, onFailure: (_) {
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.failure,
      );
    });
  }

  void parseConversationHistory(
      Map<String, dynamic> data, String conversationID) {
    final List<dynamic> conversationList =
        data["messenger"]["conversation"]["messages"]["collection"];
    final assigneeMap = data["messenger"]["conversation"]['assignee'];
    final assignee = ChatAssignee.fromJson(assigneeMap);
    entity = entity.merge(chatAssignee: assignee);
    for (dynamic item in conversationList.reversed) {
      parseHistoryMessage(item, conversationID);
    }

    // Handle if the thread is closed

    if (data["messenger"]["conversation"]['state'] == 'closed') {
      entity = entity.merge(
        chatBotUserState: ChatBotUserState.conversationClosed,
      );
    }
  }

  void parseHistoryMessage(Map<String, dynamic> data, String conversationID) {
    final conversationKey = conversationID;
    final messageKey = data["key"];
    entity = entity.merge(chatTriggerId: data["triggerId"]);
    Map<String, dynamic> messageData = data["message"];
    var message = "";

    if (messageData.containsKey("blocks") && messageData["blocks"] != null) {
      final blockData = BlocksData.fromJson(messageData["blocks"]);
      if (blockData.label != null && blockData.label!.isNotEmpty) {
        final messageuiData = MessageUiModel(
          message: blockData.label!,
          messageId: messageData["id"].toString(),
          messageSenderType: MessageSenderType.bot,
          imageUrl: data["appUser"]["avatarUrl"],
          createdAt: data["createdAt"],
        );
        if (!entity.chatDetailList.contains(messageuiData)) {
          entity = entity.merge(
              conversationKey: conversationKey,
              messageKey: messageKey,
              chatDetailList: [...entity.chatDetailList, messageuiData]);
        }
      }
      if (blockData.waitForInput) {
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
      if (messageData["state"] != null &&
          messageData["state"] == "replied" &&
          messageData["data"] != null &&
          messageData["data"]["label"] != null) {
        final messageuiData = MessageUiModel(
          message: "$sentMessageHead${messageData["data"]["label"]}",
          messageId: DateTime.now().toString(),
          messageSenderType: MessageSenderType.user,
        );
        entity = entity
            .merge(chatDetailList: [...entity.chatDetailList, messageuiData]);
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
          messageData["action"] == "assigned") {
        message = "Assigned to ${messageData["data"]["name"]}";
        entity = entity.merge(
            chatBotUserState: ChatBotUserState.waitForInput,
            chatMessageType: ChatMessageType.enterMessage);
      }
      final messageuiData = MessageUiModel(
        message: message,
        messageId: messageKey,
        messageSenderType: MessageSenderType.bot,
        imageUrl: data["appUser"]["avatarUrl"],
        createdAt: data["createdAt"],
      );
      if (!entity.chatDetailList.contains(messageuiData)) {
        entity = entity.merge(
            conversationKey: conversationKey,
            messageKey: messageKey,
            chatDetailList: [...entity.chatDetailList, messageuiData]);
      }
      if (messageData['data'] != null &&
          (messageData['data'] as Map).containsKey('next_step_uuid') &&
          messageData['data']['next_step_uuid'] == null) {
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
    );
    loadRecentConversationList();
  }
}

const sentMessageHead = 'You replied : ';
/*
{"conversation_key":"mKm2qfY28jLT2BR8uDB7LtVT","message_key":"FuxWQSQeXzZCfSwxhkjaWvTk","trigger":"2025","step":"51e87c9a-4402-4413-9540-8cb80077962d","reply":{"id":"e7100e18-f2e2-43fd-b976-b85951388479","label":"I need care","element":"button","path_id":"d2642fc1-942b-41f8-ba81-db4d7edc73fd","next_step_uuid":"51e87c9a-4402-4413-9540-8cb80077962d"},"action":"trigger_step"}
 */
