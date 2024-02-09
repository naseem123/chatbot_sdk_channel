import 'dart:convert';

import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/core/utils/shared_pref.dart';
import 'package:chatbot/core/utils/websocket_constants.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_entity.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/gateway/chatbot_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/configuration_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/init_guest_user_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/start_conversation_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_connect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_disconnect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_init_command_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_message_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_send_message_gateway.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:chatbot/features/chatbot/model/websocket/init_command_model.dart';
import 'package:chatbot/features/chatbot/model/websocket_message_model.dart';
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
    state = state.merge(
      chatBotUiState: ChatBotUiState.setupLoading,
    );

    request(InitGuestUserGatewayOutput(),
        onSuccess: (InitGuestUserSuccessInput input) {
      preference.put(PreferenceKey.sessionId, input.initData.user.sessionId);
      loadConfigurations();
      loadRecentConversationList(perPage: 100, page: 1);
      initialiseWebSocket();
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupSuccess,
      );
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
          chatBotUiState: ChatBotUiState.setupSuccess,
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

  Future<void> deleteConversation() async {
    await preference.remove(PreferenceKey.sessionId);
    entity = entity.merge(chatList: null);
    initialise();
  }

  void initialise() {
    initUserSession();
  }

  void loadRecentConversationList({int page = 1, int perPage = 3}) {
    state = state.merge(
      chatBotUiState: ChatBotUiState.conversationLoading,
    );
    request(ChatBotGatewayOutput(page: page, perPage: perPage),
        onSuccess: (ChatBotSuccessInput input) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.conversationSuccess,
        chatList: input.chatList,
      );
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.conversationFailure,
      );
    });
  }

  void initializeNewConversation() {
    if (state.chatList != null && state.chatList!.conversations.isEmpty) {
      initWebsocketConversation();
    } else {
      startNewConversation();
    }
  }

  //region chat conversation starts
  void startNewConversation() {
    state = state.merge(
      chatDetailsUiState: ChatDetailsUiState.loading,
      chatDetailList: [],
    );

    request(StartConversationGatewayOutput(),
        onSuccess: (StartConversationSuccessInput input) {
      entity =
          entity.merge(chatTriggerId: input.data.app.newConversationBots.id);
      initWebsocketCommand(chatTriggerId: state.chatTriggerId);
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
    state = state.merge(
      chatDetailsUiState: ChatDetailsUiState.loading,
      userInputOptions: [],
      chatDetailList: [],
    );

    request(WebsocketConnectGatewayOutput(),
        onSuccess: (WebsocketConnectSuccessInput input) {
      listenForMessages();
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.success,
      );
    }, onFailure: (_) {
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.failure,
      );
    });
  }

  void listenForMessages() {
    request(WebsocketMessageGatewayOutput(),
        onSuccess: (WebsocketMessageSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity;
    });
    Future.delayed(const Duration(seconds: 2), () {
      subscribeToPresenceChannel();
      subscribeToMessengerChannel();
    });
  }

  void sendMessage({required String messageData}) {
    request(
        WebsocketSendMessageGatewayOutput(
            messageToSend: getMessageData(messageData)),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
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
      return entity;
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
      return entity;
    });
  }

  void sendTriggerInitiateMessage() {
    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend: getEngageAppUserChannel()),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity;
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
      return entity;
    });
  }

  void subscribeToMessengerChannel() {
    request(
        WebsocketInitCommandGatewayOutput(
            messageToSend: getInitSubscribeMessengerChannel()),
        onSuccess: (WebsocketSendMessageSuccessInput input) {
      return entity;
    }, onFailure: (_) {
      return entity;
    });
  }

  void getNextConversationMessage(
      {required String conversationKey, required String messageKey}) {
    Future.delayed(const Duration(milliseconds: 500), () {
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
    final messageuiData = MessageUiModel(
      message: "You replied : ${inputData.label}",
      messageId: DateTime.now().toString(),
    );
    entity = entity.merge(
        chatBotUserState: ChatBotUserState.idle,
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
}

WebsocketMessageModel getMessageData(String messageText) {
  return WebsocketMessageModel.fromJson({
    "conversation_key": "TeCM3zJ1nXm87nRrThkRymfH",
    "message_key": "yMiKr8yj9PHsVeJnrGd5cp7L",
    "step": "31eac700-d836-4460-ae47-9e3fbbd0ff0e",
    "trigger": "2091",
    "reply": {
      "nextStepUuid": "bb9b493d-dcfc-49bf-8ec5-0dabcbdfcff5",
      "pathId": "800acc6e-34ba-4792-9699-9866951599b4",
      "label": "wait_for_reply",
      "html_content": messageText,
      "serialized_content":
          "{\"blocks\":[{\"key\":\"a3ggs\",\"text\":$messageText,\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}",
      "text_content": messageText
    },
    "action": "receive_conversation_part"
  });
}
