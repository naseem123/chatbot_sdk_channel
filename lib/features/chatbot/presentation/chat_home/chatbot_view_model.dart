import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBotViewModel extends ViewModel {
  const ChatBotViewModel({
    required this.chatList,
    required this.uiState,
    required this.onRetry,
    required this.onRefresh,
    required this.colorPrimary,
    required this.colorSecondary,
    required this.outputState,
    required this.title,
    required this.introText,
    required this.logo,
    required this.inBusinessHours,
    required this.tagline,
    required this.onDeleteConversationPressed,
    required this.onTick,
    required this.idleTimeout,
    required this.replyTime,
    required this.isInboundEnabled,
    required this.conversationsListUiState,
  });

  final List<Conversation> chatList;
  final ChatBotUiState uiState;
  final OutBondUiState outputState;
  final Color colorPrimary;
  final Color colorSecondary;
  final String title;
  final String introText;
  final String logo;
  final String tagline;
  final bool inBusinessHours;
  final VoidCallback onRetry;
  final AsyncCallback onRefresh;
  final VoidCallback onDeleteConversationPressed;
  final void Function(int remaining) onTick;
  final int idleTimeout;
  final String replyTime;
  final bool isInboundEnabled;
  final ConversationsListUiState conversationsListUiState;

  @override
  List<Object?> get props => [
        chatList,
        uiState,
        colorPrimary,
        colorSecondary,
        title,
        introText,
        logo,
        inBusinessHours,
        outputState,
        tagline,
        idleTimeout,
        replyTime,
        isInboundEnabled,
        conversationsListUiState,
      ];
}
