import 'package:chatbot/core/extensions/context_extension.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_view_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_details_appbar.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_user_input_editor_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_user_select_item_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_wait_for_input_button_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/message_item_widget.dart';
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
  final ScrollController _scrollController = ScrollController();

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
    final messages = viewModel.chatList.toList();
    final isLoading = viewModel.uiState == ChatDetailsUiState.loading;

    final chatMessageType = viewModel.chatMessageType;
    final chatBotUserState = viewModel.chatBotUserState;
    final userInputOptions = viewModel.userInputOptions;

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    // Scroll to bottom when list size changes or widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          70,
        ),
        child: ChatBotAppbar(
          title:  "virtualcare bot",
          subTitle: 'The team will respond as soon as possible',
          logo: "https://test.ca.digital-front-door.stg.gcp.trchq.com/assets/icons8-bot-50-ccd9ed66d2850c1bd0737308082e76890d697c8e.png",
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  itemCount: messages.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageItemWidget(message: message);
                  },
                ),
              ),
            ),
            if (chatBotUserState == ChatBotUserState.waitForInput && chatMessageType == ChatMessageType.askForInputButton && userInputOptions.length > 3)
              ...[
                ChatUserSelectItemWidget(
                    buttons: userInputOptions,
                    color: viewModel.colorPrimary,
                    colorSecondary: viewModel.colorSecondary,
                    onUserInputTriggered: (blockData) {
                      viewModel.onUserInputTriggered(blockData);
                    })
              ],
            if (chatBotUserState == ChatBotUserState.waitForInput && chatMessageType == ChatMessageType.askForInputButton && userInputOptions.length <= 3)
            ...[
                ChatWaitForInputButtonWidget(
                    buttons: userInputOptions,
                    color: viewModel.colorSecondary,
                    onUserInputTriggered: (blockData) {
                      viewModel.onUserInputTriggered(blockData);
                    })
              ],
            if (chatBotUserState == ChatBotUserState.conversationClosed)
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: context.bottomPadding.bottom),
                color: Colors.white,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'This conversation has ended',
                  style: GoogleFonts.arimo(
                      color: context.secondaryColor.mostlyBlack,
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w800),
                ),
              ),
            if (chatBotUserState != ChatBotUserState.conversationClosed &&
                viewModel.chatMessageType == ChatMessageType.enterMessage)
              ChatUserInputEditorWidget(
                textEditingController: messageController,
                onMessageEntered: (message) {
                  viewModel.onMessageEntered(messageController.text);
                  messageController.clear();
                },
              )
          ],
        ),
      ),
    );
  }
}
