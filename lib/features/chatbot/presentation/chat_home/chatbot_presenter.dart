import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_ui_output.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_use_case.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/chatbot_view_model.dart';
import 'package:chatbot/providers/src/usecase_providers.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatBotPresenter
    extends Presenter<ChatBotViewModel, ChatBotUIOutput, ChatBotUseCase> {
  ChatBotPresenter({
    super.key,
    required super.builder,
  }) : super(provider: chatBotUseCaseProvider);

  @override
  void onLayoutReady(BuildContext context, ChatBotUseCase useCase) {
    useCase.initUserSession();
  }

  @override
  ChatBotViewModel createViewModel(
      ChatBotUseCase useCase, ChatBotUIOutput output) {
    return ChatBotViewModel(
      chatList: output.chatList,
      outputState: output.outBondUiState,
      onRefresh: () async {
        useCase.initUserSession();
      },
      onRetry: () {
        useCase.initUserSession();
      },
      uiState: output.chatBotUiState,
      title: output.appSettings.app.greetings,
      tagline: output.appSettings.app.tagline,
      logo: output.appSettings.app.logo,
      colorPrimary: output.appSettings.app.customizationColors.primary.toColor,
      colorSecondary:
          output.appSettings.app.customizationColors.secondary.toColor,
      introText: output.appSettings.app.intro,
      inBusinessHours: output.appSettings.app.inBusinessHours,
      onDeleteConversationPressed: () {
        useCase.clearSession();
      },
      idleTimeout: output.idleTimeout,
      onTick: useCase.onTick,
      replyTime: output.appSettings.app.replyTime,
      isInboundEnabled: output.isInboundEnabled,
      conversationsListUiState: output.conversationsListUiState,
    );
  }

  @override
  void onOutputUpdate(BuildContext context, ChatBotUIOutput output) {
    final state = output.chatBotUiState;

    if (state == ChatBotUiState.triggerReceived) {
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        if (GoRouter.of(context).routeInformationProvider.value.location !=
            "/chatDetail") {
          context.push("/chatDetail");
        }
      });
    }
  }

  @override
  void onDestroy(ChatBotUseCase useCase) {
    useCase.resetData();
    useCase.disconnectMessageChannel();
    super.onDestroy(useCase);
  }
}

enum OutBondUiState {
  outBondStateIdle,
  outBondStateOpen,
  outBondStateClose,
}

enum ChatBotUiState {
  idle,
  conversationLoading,
  conversationSuccess,
  conversationFailure,
  setupLoading,
  setupSuccess,
  setupFailure,
  triggerReceived,
}

enum ConversationsListUiState {
  idle,
  loading,
}
