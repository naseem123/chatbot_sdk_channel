import 'package:chatbot/core/widgets/idle_detector.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_view_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/conversation_list.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/chat_closed_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/chat_home_appbar.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/conversation_list_widget.dart';
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
    if ([ChatBotUiState.conversationLoading, ChatBotUiState.setupLoading]
        .contains(viewModel.uiState)) {
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
      bool showPreviousChatList = viewModel.chatList.length > 3;

      child = RefreshIndicator(
        onRefresh: viewModel.onRefresh,
        child: Container(
          color: const Color(0xFFfbf9f9),
          child: Column(
            children: [
              if (viewModel.chatList.isNotEmpty)
                ConversationWidget(
                    chatList: viewModel.chatList.take(3).toList(),
                    onSeeConversationListPressed: () {
                      showConversationListPage(context,
                          chatList: viewModel.chatList,
                          color: viewModel.colorPrimary,
                          taglineText: viewModel.tagline,
                          idleTimeout: viewModel.idleTimeout);
                    },
                    onDeleteConversationPressed: () {
                      viewModel.onDeleteConversationPressed();
                    },
                    showViewAllConversation: showPreviousChatList),
              if (viewModel.outputState != OutBondUiState.outBondStateIdle)
                if (inBusinessHours)
                  StartNewConversationWidget(
                    buttonColor: viewModel.colorSecondary,
                    onStartConversationPressed: () {
                      context.push("/chatDetail");
                    },
                    replyTime:viewModel.replyTime,
                    onSeePreviousPressed: () {
                      showConversationListPage(context,
                          chatList: viewModel.chatList,
                          color: viewModel.colorPrimary,
                          taglineText: viewModel.tagline,
                          idleTimeout: viewModel.idleTimeout);
                    },
                  )
                else
                  const ChatClosedWidget()
            ],
          ),
        ),
      );
    }
    return IdleDetector(
      idleTime: viewModel.idleTimeout,
      onIdle: viewModel.onIdleSessionTimeout,
      child: Scaffold(
        appBar: ChatBotAppbar(
          title: viewModel.title,
          subtitle: viewModel.introText,
          colorPrimary: viewModel.colorPrimary,
          logo: viewModel.logo,
        ),
        body: child,
      ),
    );
  }

  void showConversationListPage(BuildContext context,
      {required List<Conversation> chatList,
      required Color color,
      required String taglineText,
      required int idleTimeout}) {
    showConversationPage(context,
        conversationList: chatList,
        colorPrimary: color,
        taglineText: taglineText,
        idleTimeout: idleTimeout);
  }
}
