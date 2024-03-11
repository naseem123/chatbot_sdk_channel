import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/features/chatbot/domain/chat_details_ui_output.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_use_case.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_view_model.dart';
import 'package:chatbot/providers/src/usecase_providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatDetailsPresenter extends Presenter<ChatDetailsViewModel,
    ChatDetailsUIOutput, ChatBotUseCase> {
  ChatDetailsPresenter({
    super.key,
    required super.builder,
    required this.conversationID,
  }) : super(provider: chatBotUseCaseProvider);

  final String conversationID;

  @override
  void onLayoutReady(BuildContext context, ChatBotUseCase useCase) {
    if (conversationID.isEmpty) {
      useCase.initializeNewConversation();
    } else {
      useCase.loadChatHistory(conversationID: conversationID);
    }
  }

  @override
  ChatDetailsViewModel createViewModel(
      ChatBotUseCase useCase, ChatDetailsUIOutput output) {
    return ChatDetailsViewModel(
      uiState: output.chatDetailsUiState,
      chatList: output.chatDetailList,
      onMessageEntered: (String message, ChatMessageType chatMessageType) {
        useCase.sendMessage(messageData: message, messageType: chatMessageType);
      },
      chatMessageType: output.chatMessageType,
      chatBotUserState: output.chatBotUserState,
      userInputOptions: output.userInputOptions,
      onUserInputTriggered: (Block inputData) {
        useCase.sendUserInput(inputData: inputData);
      },
      colorSecondary:
          output.appSettings.app.customizationColors.secondary.toColor,
      colorPrimary: output.appSettings.app.customizationColors.primary.toColor,
      backButtonPressed: () {
        //  useCase.loadRecentConversationList();
      },
      chatAssignee: output.chatAssignee,
      idleTimeout: output.idleTimeout,
      onIdleSessionTimeout: useCase.clearSession,
      loadMoreChats: useCase.loadMoreChats,
      currentPage: output.currentPage,
      totalPages: output.totalPages,
      onSurveySubmitted: useCase.onSurveySubmitted,
        isAgentTyping: output.isAgentTyping,
    );
  }

  @override
  void onOutputUpdate(BuildContext context, ChatDetailsUIOutput output) {
    if (output.chatSessionState == ChatSessionState.sessionUnavailable) {
      context.pop();
    }
  }

  @override
  void onDestroy(ChatBotUseCase useCase) {
    useCase.resetData();
    super.onDestroy(useCase);
  }
}

enum ChatDetailsUiState {
  idle,
  loading,
  success,
  failure,
}

enum ChatListUiState {
  idle,
  loading,
}
