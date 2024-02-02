import 'package:chatbot/features/chatbot/presentation/chatbot_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chatbot_view_model.dart';
import 'package:chatbot/features/chatbot/presentation/widgets/appbar_widget.dart';
import 'package:chatbot/features/chatbot/presentation/widgets/conversation_item.dart';
import 'package:chatbot/features/chatbot/presentation/widgets/delete_recent_conversations.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

import 'widgets/loading_failed_widget.dart';

class ChatBotUI extends UI<ChatBotViewModel> {
  ChatBotUI({super.key});

  @override
  ChatBotPresenter create(PresenterBuilder<ChatBotViewModel> builder) {
    return ChatBotPresenter(builder: builder);
  }

  @override
  Widget build(BuildContext context, ChatBotViewModel viewModel) {
    Widget child;
    if (viewModel.uiState == ChatBotUiState.conversationLoading) {
      child = const Center(child: CircularProgressIndicator());
    } else if (viewModel.uiState == ChatBotUiState.conversationFailure) {
      child = LoadingFailed(onRetry: viewModel.onRetry);
    } else {
      child = RefreshIndicator(
        onRefresh: viewModel.onRefresh,
        child: Container(
          color: const Color(0xFFfbf9f9),
          child: ConversationWidget(context, viewModel),
        ),
      );
    }

    return Scaffold(
      appBar: ChatbotAppbar(appSettingg: viewModel.appSettings),
      body: child,
    );
  }

  Container ConversationWidget(
      BuildContext context, ChatBotViewModel viewModel) {
    return Container(
      height: 380,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Continue the conversation',
                style: context.textTheme.captionBold.copyWith(
                  color: context.colorScheme.primary,
                  fontSize: 19,
                ),
              ),
              IconButtons(
                  onPressed: () =>
                      showDeleteConversationConfirmationPopup(context),
                  path: 'assets/icons/reload_icon.svg'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final chatData = viewModel.chatList[index];
                return ConversationItem(chatData: chatData);
              },
              itemCount: viewModel.chatList.length,
            ),
          ),
          Text(
            'view all conversations',
            style: context.textTheme.captionBold
                .copyWith(color: const Color(0xFF4D4C4C), fontSize: 12),
          )
        ],
      ),
    );
  }
}
