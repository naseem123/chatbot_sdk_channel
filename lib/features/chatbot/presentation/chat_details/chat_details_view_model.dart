import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

class ChatDetailsViewModel extends ViewModel {
  const ChatDetailsViewModel({
    required this.uiState,
    required this.onMessageEntered,
    required this.chatList,
    required this.chatBotUserState,
    required this.chatMessageType,
    required this.userInputOptions,
    required this.onUserInputTriggered,
    required this.colorSecondary,
    required this.colorPrimary,
    required this.backButtonPressed,
  });

  final ChatDetailsUiState uiState;
  final List<MessageUiModel> chatList;
  final Function(String message) onMessageEntered;
  final VoidCallback backButtonPressed;

  final Color colorSecondary;
  final Color colorPrimary;

  final ChatBotUserState chatBotUserState;
  final ChatMessageType chatMessageType;
  final List<Block> userInputOptions;
  final Function(Block input) onUserInputTriggered;

  @override
  List<Object?> get props => [
        uiState,
        chatList,
        chatBotUserState,
        chatMessageType,
        userInputOptions,
        colorSecondary,
        colorPrimary,
        backButtonPressed,
      ];
}
