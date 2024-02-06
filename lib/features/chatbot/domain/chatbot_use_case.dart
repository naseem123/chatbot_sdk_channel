import 'package:chatbot/core/utils/shared_pref.dart';
import 'package:chatbot/features/chatbot/domain/chat_details_ui_output.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_entity.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_ui_output.dart';
import 'package:chatbot/features/chatbot/gateway/chatbot_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/configuration_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/init_guest_user_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/start_conversation_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_connect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_disconnect_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_message_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/websocket/websocket_send_message_gateway.dart';
import 'package:chatbot/features/chatbot/model/websocket_message_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:chatbot/providers.dart';
import 'package:clean_framework/clean_framework.dart';

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
          appSettings: input.appSettings);
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.setupFailure,
      );
    });
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

  //region chat conversation starts
  void startNewConversation() {
    state = state.merge(
      chatDetailsUiState: ChatDetailsUiState.loading,
      chatDetailList: [],
    );

    request(StartConversationGatewayOutput(),
        onSuccess: (StartConversationSuccessInput input) {
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
      return entity.merge(
        chatDetailList: state.chatDetailList,
      );
    }, onFailure: (_) {
      return entity;
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

  /* ************************************* / 
  //  LOAD CHAT DETAILS 
  
  /// 
 / ************************************* */
/*  void loadPreviousChatDetails({int page = 1, String id = "zmJCb8HTLKPaSMYp4RBtPgJa"}) {
    state = state.merge(
      chatDetailsUiState: ChatDetailsUiState.loading,
    );
    String? sessionId = preference.get<String>(PreferenceKey.sessionId);

    if (sessionId.isNullOrEmpty) {
      sessionId = getRandomString();
    }
    sessionId =
        'eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9LWlcxaGFXeEpJaEYwWlhOMFFIUmxjM1F1WTJ3R09nWkZWRG9KZEhsd1pUQT0iLCJleHAiOm51bGwsInB1ciI6ImxvZ2luIn19--8eb78acd4acda60d78a3c17059a4297312469ccb93444d789e64deac0890952f';
    request(ChatDetailsGatewayOutput(page: page, id: id),
        onSuccess: (ChatDetailsSuccessInput input) {
      return entity.merge(
        chatDetailsUiState: ChatDetailsUiState.success,
        // chatHistoryData: input.chatHistoryData,
        
      );
    }, onFailure: (_) {
      return entity.merge(
        chatBotUiState: ChatBotUiState.conversationFailure,
      );
    });
  }*/
}

class ChatBotUIOutputTransformer
    extends OutputTransformer<ChatBotEntity, ChatBotUIOutput> {
  @override
  ChatBotUIOutput transform(ChatBotEntity entity) {
    return ChatBotUIOutput(
      chatBotUiState: entity.chatBotUiState,
      chatList: entity.chatList?.conversations ?? [],
      appSettings: entity.appSettings,
    );
  }
}

class ChatDetailsUIOutputTransformer
    extends OutputTransformer<ChatBotEntity, ChatDetailsUIOutput> {
  @override
  ChatDetailsUIOutput transform(ChatBotEntity entity) {
    return ChatDetailsUIOutput(
      chatDetailsUiState: entity.chatDetailsUiState,
      chatDetailList: entity.chatDetailList,
    );
  }
}

class ChatDetailsUIInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketConnectSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketConnectSuccessInput input) {
    return entity;
  }
}

class ChatDetailsConnectMessageInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketConnectSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketConnectSuccessInput input) {
    return entity;
  }
}

class ChatDetailsGetMessageInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketMessageSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketMessageSuccessInput input) {
    return entity.merge(
        chatDetailList: [...entity.chatDetailList, input.message.reply.label]);
  }
}

class ChatDetailsSendMessageInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketSendMessageSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketSendMessageSuccessInput input) {
    return entity;
  }
}

class ChatDetailsDisconnectMessageInputTransformer
    extends InputTransformer<ChatBotEntity, WebsocketDisconnectSuccessInput> {
  @override
  ChatBotEntity transform(
      ChatBotEntity entity, WebsocketDisconnectSuccessInput input) {
    return entity;
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
