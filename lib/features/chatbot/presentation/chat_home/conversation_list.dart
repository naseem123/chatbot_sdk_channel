import 'package:chatbot/core/widgets/idle_detector.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resources/resources.dart';

import 'widgets/conversation_item.dart';
import 'widgets/conversation_list_appbar.dart';

showConversationPage(context,
    {required List<Conversation> conversationList,
    required Color colorPrimary,
    required String taglineText,
    required int idleTimeout}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: false,
    builder: (context) => IdleDetector(
      idleTime: idleTimeout,
      onIdle: () => context.pop(),
      child: ConversationList(
          conversationList: conversationList,
          colorPrimary: colorPrimary,
          taglineText: taglineText),
    ),
  );
}

class ConversationList extends StatelessWidget {
  ConversationList({
    super.key,
    required this.conversationList,
    required this.colorPrimary,
    required this.taglineText,
  });

  final String taglineText;
  final List<Conversation> conversationList;
  final Color colorPrimary;
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatList = conversationList;
    return Scaffold(
      appBar: ConversationAppBar(
        title: 'Conversations',
        subtitle: '',
        colorPrimary: colorPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final chatData = chatList[index];
                    return ConversationItem(
                      chatData: chatData,
                      onPressed: () {
                        context.push("/chatDetail",
                            extra: {'conversationId': chatData.key});
                      },
                      isLastItem: chatList.length - 1 == index,
                    );
                  },
                  itemCount: chatList.length,
                ),
              ),
            ),
            if (taglineText.isNotEmpty) ...[
              const Divider(thickness: 1),
              Text(
                taglineText,
                style: context.textTheme.captionRegular.copyWith(
                    color: context.secondaryColor.matterhorn, fontSize: 14),
              )
            ]
          ],
        ),
      ),
    );
  }
}
