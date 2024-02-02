import 'package:chatbot/features/chatbot/domain/chatbot_ui_output.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_use_case.dart';
import 'package:chatbot/features/chatbot/presentation/chatbot_view_model.dart';
import 'package:chatbot/providers/src/usecase_providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter/material.dart';

class ChatBotPresenter
    extends Presenter<ChatBotViewModel, ChatBotUIOutput, ChatBotUseCase> {
  ChatBotPresenter({
    super.key,
    required super.builder,
  }) : super(provider: chatBotUseCaseProvider);

  @override
  void onLayoutReady(BuildContext context, ChatBotUseCase useCase) {
    useCase.loadConfigurations();
    useCase.loadChats();
  }

  @override
  ChatBotViewModel createViewModel(
      ChatBotUseCase useCase, ChatBotUIOutput output) {
    return ChatBotViewModel(
      chatList: output.chatList,
      onRefresh: () async {},
      onRetry: () {},
      uiState: output.chatBotUiState,
      appSettings: output.appSettings,
    );
  }
}

enum ChatBotUiState {
  conversationLoading,
  conversationSuccess,
  conversationFailure,
  setupLoading,
  setupSuccess,
  setupFailure
}
