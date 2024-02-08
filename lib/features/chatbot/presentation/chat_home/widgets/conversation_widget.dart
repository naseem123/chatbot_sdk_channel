import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/conversation_item.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'delete_recent_conversations.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({
    super.key,
    required this.chatList,
    required this.onDeleteConversationPressed,
    required this.onSeeConvesationListPressed,
    required this.showViewAllConversation,
  });

  final bool showViewAllConversation;
  final VoidCallback onSeeConvesationListPressed;
  final VoidCallback onDeleteConversationPressed;
  final List<Conversation> chatList;

  @override
  Widget build(BuildContext context) {
    final hasChatList = chatList.isNotEmpty;
    return Container(
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
              if (hasChatList)
                IconButtons(
                    onPressed: () => showDeleteConversationConfirmationPopup(
                        context, onDeleteConversationPressed),
                    path: 'assets/icons/reload_icon.svg'),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final chatData = chatList[index];
              return ConversationItem(
                chatData: chatData,
                onPressed: () {
                  context.push("/chatDetail");
                },
                isLastItem:chatList.length-1==index
              );
            },
            itemCount: chatList.length,
          ),
          if (showViewAllConversation && hasChatList)
            InkWell(
              onTap: onSeeConvesationListPressed,
              child: Text(
                'view all conversations',
                style: context.textTheme.captionBold.copyWith(
                    color: context.secondaryColor.matterhorn, fontSize: 12),
              ),
            )
        ],
      ),
    );
  }
}
