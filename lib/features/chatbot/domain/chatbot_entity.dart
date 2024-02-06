import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:clean_framework/clean_framework.dart';

import '../model/app_settings_model.dart';
import '../model/conversation_model.dart';

class ChatBotEntity extends Entity {
  final ChatBotUiState chatBotUiState;
  final ChatConversationSuccessInput? chatList;
  final AppSettings appSettings;

  //Chat details fields
  final ChatDetailsUiState chatDetailsUiState;
  final List<String> chatDetailList;

  const ChatBotEntity({
    this.chatBotUiState = ChatBotUiState.conversationLoading,
    this.chatList,
    this.appSettings = const AppSettings(),
    this.chatDetailsUiState = ChatDetailsUiState.idle,
    this.chatDetailList = const [],
  });

  ChatBotEntity merge({
    ChatBotUiState? chatBotUiState,
    ChatConversationSuccessInput? chatList,
    AppSettings? appSettings,
    ChatDetailsUiState? chatDetailsUiState,
    List<String>? chatDetailList,
  }) {
    return ChatBotEntity(
      chatBotUiState: chatBotUiState ?? this.chatBotUiState,
      chatList: chatList ?? this.chatList,
      appSettings: appSettings ?? this.appSettings,
      chatDetailsUiState: chatDetailsUiState ?? this.chatDetailsUiState,
      chatDetailList: chatDetailList ?? this.chatDetailList,
    );
  }

  @override
  List<Object?> get props => [
        chatBotUiState,
        chatList,
        appSettings,
        chatDetailsUiState,
        chatDetailList
      ];
}
