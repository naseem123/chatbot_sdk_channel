import 'package:chatbot/core/widgets/anim/anim_three_in_out.dart';
import 'package:chatbot/core/widgets/idle_detector.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_view_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_details_appbar.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_list_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_user_input_editor_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_user_select_item_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_wait_for_input_button_widget.dart';
import 'package:chatbot/i18n/app_localization.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resources/resources.dart';

class ChatDetailsUI extends UI<ChatDetailsViewModel> {
  ChatDetailsUI({
    super.key,
    this.conversationID = "",
  });

  final String conversationID;
  final messageController = TextEditingController();

  @override
  ChatDetailsPresenter create(PresenterBuilder<ChatDetailsViewModel> builder) {
    return ChatDetailsPresenter(
      builder: builder,
      conversationID: conversationID,
    );
  }

  @override
  Widget build(BuildContext context, ChatDetailsViewModel viewModel) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final messages = viewModel.chatList;
    final isLoading = viewModel.uiState == ChatDetailsUiState.loading;

    final chatMessageType = viewModel.chatMessageType;
    final chatBotUserState = viewModel.chatBotUserState;
    final userInputOptions = viewModel.userInputOptions;
    final chatBotAssignee = viewModel.chatAssignee;
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    // Scroll to bottom when list size changes or widget is first built

    return IdleDetector(
      idleTime: viewModel.idleTimeout,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ChatBotAppbar(
            title: chatBotAssignee.assignee,
            subTitle: '',
            logo: chatBotAssignee.assigneeImage,
            colorPrimary: viewModel.colorPrimary,
            backButtonPressed: viewModel.backButtonPressed,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: (viewInsets.bottom > 0) ? 8.0 : 0.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ChatListWidget(
                      currentPage: viewModel.currentPage,
                      totalPage: viewModel.totalPages,
                      messages: messages,
                      secondaryColor: viewModel.colorSecondary,
                      colorPrimary: viewModel.colorPrimary,
                      loadMoreChats: viewModel.loadMoreChats,
                      onSurveyStartClicked: viewModel.onSurveySubmitted,
                    ),
                  ),
                ),
              ),
              if (viewModel.isAgentTyping) ...[
                SafeArea(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SpinKitThreeInOut(
                        size: 20,
                        color: viewModel.colorSecondary,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('agent_typing'),
                        style: GoogleFonts.inter(
                          color: context.secondaryColor.mostlyBlack,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
              ] else
                const SizedBox(
                  height: 23,
                ),
              if (chatBotUserState == ChatBotUserState.waitForInput &&
                  chatMessageType == ChatMessageType.askForInputButton &&
                  userInputOptions.length > 3) ...[
                ChatUserSelectItemWidget(
                    buttons: userInputOptions,
                    color: viewModel.colorPrimary,
                    colorSecondary: viewModel.colorSecondary,
                    onUserInputTriggered: (blockData) {
                      viewModel.onUserInputTriggered(blockData);
                    })
              ],
              if (chatBotUserState == ChatBotUserState.waitForInput &&
                  chatMessageType == ChatMessageType.askForInputButton &&
                  userInputOptions.length <= 3) ...[
                ChatWaitForInputButtonWidget(
                    buttons: userInputOptions,
                    color: viewModel.colorSecondary,
                    onUserInputTriggered: (blockData) {
                      viewModel.onUserInputTriggered(blockData);
                    })
              ],
              if (chatBotUserState == ChatBotUserState.conversationClosed)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: context.secondaryColor.ligthRed,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context).translate('conversation_end'),
                    style: GoogleFonts.inter(
                        color: context.secondaryColor.mostlyBlack,
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              if (chatBotUserState != ChatBotUserState.conversationClosed &&
                      viewModel.chatMessageType ==
                          ChatMessageType.enterMessage ||
                  viewModel.chatMessageType ==
                      ChatMessageType.enterMessageAndTrigger)
                ChatUserInputEditorWidget(
                  textEditingController: messageController,
                  colorSecondary: viewModel.colorSecondary,
                  onMessageEntered: (message) {
                    viewModel.onMessageEntered(
                        messageController.text, viewModel.chatMessageType);
                    messageController.clear();
                  },
                ),
              if (chatBotUserState == ChatBotUserState.survey &&
                  viewModel.chatMessageType == ChatMessageType.survey)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: context.secondaryColor.ligthRed,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context).translate('reply_above'),
                    style: GoogleFonts.inter(
                        color: context.secondaryColor.mostlyBlack,
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
