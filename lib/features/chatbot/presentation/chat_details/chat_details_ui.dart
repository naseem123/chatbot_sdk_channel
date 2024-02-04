import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_presenter.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/chat_details_view_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/avatar.dart';
import 'package:chatbot/features/chatbot/presentation/chat_details/widgets/message_item_widget.dart';
import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resources/resources.dart';

class ChatDetailsUI extends UI<ChatDetailsViewModel> {
  ChatDetailsUI({super.key});

  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ChatDetailsViewModel viewModel) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final messages = viewModel.chatList;
    final isLoading = viewModel.uiState == ChatDetailsUiState.loading;

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
      appBar: AppBar(
        title: const Text("Chat Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: (viewInsets.bottom > 0) ? 8.0 : 0.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    const showImage = true;
                    return Row(
                      //Change Alignment after checking whether the message is from the user
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (showImage)
                          const Avatar(
                            imageUrl:
                                "https://test.ca.digital-front-door.stg.gcp.trchq.com/assets/icons8-bot-50-ccd9ed66d2850c1bd0737308082e76890d697c8e.png",
                            radius: 12,
                          ),
                        MessageItemWidget(message: message),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // TODO: Send an image
                      },
                      icon: const Icon(Icons.attach_file),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              context.secondaryColor.gainsboro.withAlpha(100),
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (messageController.text.trim().isNotEmpty) {
                                viewModel
                                    .onMessageEntered(messageController.text);
                                messageController.clear();
                              }
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ChatDetailsPresenter create(PresenterBuilder<ChatDetailsViewModel> builder) {
    return ChatDetailsPresenter(
      builder: builder,
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
