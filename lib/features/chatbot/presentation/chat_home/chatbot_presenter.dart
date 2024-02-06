import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_ui_output.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_use_case.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_view_model.dart';
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
    useCase.initUserSession();
    // useCase.loadRecentConversationList();
  }

  @override
  ChatBotViewModel createViewModel(
      ChatBotUseCase useCase, ChatBotUIOutput output) {
    return ChatBotViewModel(
      chatList: output.chatList,
      onRefresh: () async {},
      onRetry: () {},
      uiState: output.chatBotUiState,
      title: output.appSettings.app.greetings,
      logo: output.appSettings.app.logo,
      colorPrimary: output.appSettings.app.customizationColors.primary.toColor,
      colorSecondary:
          output.appSettings.app.customizationColors.secondary.toColor,
      introText: output.appSettings.app.intro,
      inBusinessHours: output.appSettings.app.inBusinessHours,
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
