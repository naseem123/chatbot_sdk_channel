import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_view_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/appbar_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/chat_closed_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/conversation_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/loading_failed_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/start_new_conversation_widget.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatBotUI extends UI<ChatBotViewModel> {
  ChatBotUI({super.key});

  @override
  ChatBotPresenter create(PresenterBuilder<ChatBotViewModel> builder) {
    return ChatBotPresenter(builder: builder);
  }

  @override
  Widget build(BuildContext context, ChatBotViewModel viewModel) {
    Widget child;
    print("viewModel.uiState = ${viewModel.uiState}");
    if (viewModel.uiState == ChatBotUiState.conversationLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if ([ChatBotUiState.conversationFailure, ChatBotUiState.setupFailure]
        .contains(viewModel.uiState)) {
      child = LoadingFailed(onRetry: viewModel.onRetry);
    } else {
      bool inBusinessHours = viewModel.inBusinessHours;
      child = RefreshIndicator(
        onRefresh: viewModel.onRefresh,
        child: Container(
          color: const Color(0xFFfbf9f9),
          child: Column(
            children: [
              ConversationWidget(chatList: viewModel.chatList),
              if (inBusinessHours)
                StartNewConversationWidget(
                  buttonColor: viewModel.colorSecondary,
                  onStartConversationPressed: () {
                    context.push("/chatDetail");
                  },
                )
              else
                const ChatClosedWidget()
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: ChatBotAppbar(
        title: viewModel.title,
        subtitle: viewModel.introText,
        colorPrimary: viewModel.colorPrimary,
        logo: viewModel.logo,
      ),
      body: child,
    );
  }
}
