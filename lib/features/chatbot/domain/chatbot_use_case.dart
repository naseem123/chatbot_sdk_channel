import 'package:chatbot/features/chatbot/domain/chatbot_entity.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_ui_output.dart';
import 'package:chatbot/features/chatbot/gateway/chatbot_gateway.dart';
import 'package:chatbot/features/chatbot/gateway/configuration_gateway.dart';
import 'package:chatbot/features/chatbot/presentation/chatbot_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

class ChatBotUseCase extends UseCase<ChatBotEntity> {
  ChatBotUseCase()
      : super(
          entity: const ChatBotEntity(),
          transformers: [
            ChatBotUIOutputTransformer(),
          ],
        );

  void loadConfigurations() {
    // TODO after we done session implimentation
    // String? sessionId = preference.get<String>(PreferenceKey.sessionId);
    //
    // if (sessionId.isNullOrEmpty) {
    //   sessionId = getRandomString();
    // }

    state = state.merge(
      chatBotUiState: ChatBotUiState.setupLoading,
    );
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

  void loadChats({int page = 1, int perPage = 3}) {
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
}

class ChatBotUIOutputTransformer
    extends OutputTransformer<ChatBotEntity, ChatBotUIOutput> {
  @override
  ChatBotUIOutput transform(ChatBotEntity entity) {
    return ChatBotUIOutput(
      chatBotUiState: entity.chatBotUiState,
      chatList: entity.chatList?.conversations ?? [],
      appSettings: entity.appSettings!,
    );
  }
}
