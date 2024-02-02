import 'package:chatbot/features/chatbot/presentation/chatbot_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

import '../model/app_configuration_model.dart';
import '../model/conversation_model.dart';

class ChatBotEntity extends Entity {
  final ChatBotUiState chatBotUiState;
  final ChatConversationSuccessInput? chatList;
  final AppSettings? appSettings;

  const ChatBotEntity({
    this.chatBotUiState = ChatBotUiState.conversationLoading,
    this.chatList,
    this.appSettings,
  });

  ChatBotEntity merge({
    ChatBotUiState? chatBotUiState,
    ChatConversationSuccessInput? chatList,
    AppSettings? appSettings,
  }) {
    return ChatBotEntity(
      chatBotUiState: chatBotUiState ?? this.chatBotUiState,
      chatList: chatList ?? this.chatList,
      appSettings: appSettings ?? this.appSettings,
    );
  }

  @override
  List<Object?> get props => [
        chatBotUiState,
        chatList,
        appSettings,
      ];
}
