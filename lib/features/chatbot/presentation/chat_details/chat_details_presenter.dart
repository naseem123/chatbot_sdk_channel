import 'package:chatbot/features/chatbot/domain/chat_details_ui_output.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_use_case.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_view_model.dart';
import 'package:chatbot/providers/src/usecase_providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter/material.dart';

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
      useCase.startNewConversation();
      //useCase.initWebsocketConversation();
    }
  }

  @override
  ChatDetailsViewModel createViewModel(
      ChatBotUseCase useCase, ChatDetailsUIOutput output) {
    return ChatDetailsViewModel(
        uiState: output.chatDetailsUiState,
        chatList: output.chatDetailList,
        onMessageEntered: (String message) {
          useCase.sendMessage(messageData: message);
        },
        chatMessageType: output.chatMessageType,
        chatBotUserState: output.chatBotUserState,
        userInputOptions: output.userInputOptions,
        onUserInputTriggered: (Block inputData) {
          useCase.sendUserInput(inputData: inputData);
        });
  }
}

enum ChatDetailsUiState {
  idle,
  loading,
  success,
  failure,
}