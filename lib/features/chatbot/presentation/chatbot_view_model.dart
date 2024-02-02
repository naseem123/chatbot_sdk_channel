import 'package:chatbot/features/chatbot/model/app_configuration_model.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/features/chatbot/presentation/chatbot_presenter.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/foundation.dart';

class ChatBotViewModel extends ViewModel {
  const ChatBotViewModel({
    required this.chatList,
    required this.uiState,
    required this.onRetry,
    required this.onRefresh,
    required this.appSettings,
  });

  final List<Conversation> chatList;
  final ChatBotUiState uiState;
  final AppSettings? appSettings;

  final VoidCallback onRetry;
  final AsyncCallback onRefresh;

  @override
  List<Object?> get props => [chatList, uiState, appSettings];
}
