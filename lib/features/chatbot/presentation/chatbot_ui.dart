import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/features/chatbot/presentation/chatbot_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chatbot_view_model.dart';
import 'package:chatbot/features/chatbot/presentation/widgets/appbar_widget.dart';
import 'package:chatbot/features/chatbot/presentation/widgets/recent_conversation_list_widget.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
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
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (viewModel.uiState == ChatBotUiState.conversationFailure) {
      child = LoadingFailed(onRetry: viewModel.onRetry);
    } else {
      child = RefreshIndicator(
        onRefresh: viewModel.onRefresh,
        child: Container(
          color: const Color(0xFFfbf9f9),
          child: RecentConversationListWidget(
            chatList: viewModel.chatList,
          ),
        ),
      );
    }

    final appBarColor =
        viewModel.appSettings?.app.customizationColors.primary.toColor;
    final appTitle = viewModel.appSettings?.app.name;
    return Scaffold(
      appBar: ChatBotAppBar(
        title: appTitle ?? "ChatBot",
        appBarColor: appBarColor ?? Colors.black,
      ),
      body: child,
    );
  }
}
