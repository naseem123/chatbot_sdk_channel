import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_view_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/avatar.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_user_input_editor_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_user_select_item_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/chat_wait_for_input_button_widget.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/message_item_widget.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final messages = viewModel.chatList;
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
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          70,
        ),
        child: AppBar(
          backgroundColor: viewModel.colorPrimary,
          leading: Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
            ),
            color: viewModel.colorPrimary,
            child: IconButton(
              onPressed: () {
                viewModel.backButtonPressed();
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          title: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 2,
                  ),
                  child: ImageIcons(
                    path: 'assets/icons/message_icon.svg',
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    child: Text(
                      "Chat with us!",
                      style: GoogleFonts.arimo(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          titleTextStyle: context.textTheme.captionRegular.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: (viewInsets.bottom > 0) ? 8.0 : 0.0,
          ),
          child: Column(
            children: [
              Expanded(
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
              if (chatBotUserState == ChatBotUserState.waitForInput &&
                  chatMessageType == ChatMessageType.askForInputButton)
                if (userInputOptions.length > 3) ...[
                  ChatUserSelectItemWidget(
                      buttons: userInputOptions,
                      color: viewModel.colorPrimary,
                      colorSecondary: viewModel.colorSecondary,
                      onUserInputTriggered: (blockData) {
                        viewModel.onUserInputTriggered(blockData);
                      })
                ] else ...[
                  ChatWaitForInputButtonWidget(
                      buttons: userInputOptions,
                      color: viewModel.colorSecondary,
                      onUserInputTriggered: (blockData) {
                        viewModel.onUserInputTriggered(blockData);
                      })
                ],
              if (viewModel.chatMessageType == ChatMessageType.enterMessage)
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
      ),
    );
  }

  Widget chatDetailAppBar(BuildContext context) => AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Avatar(
              imageUrl:
                  "https://test.ca.digital-front-door.stg.gcp.trchq.com/assets/icons8-bot-50-ccd9ed66d2850c1bd0737308082e76890d697c8e.png",
              radius: 18,
            ),
            // const SizedBox(height: 2.0),
            Text(
              "Bot",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(width: 8.0),
        ],
      );
}
