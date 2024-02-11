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
    required this.onSeeConversationListPressed,
    required this.showViewAllConversation,
  });

  final bool showViewAllConversation;
  final VoidCallback onSeeConversationListPressed;
  final VoidCallback onDeleteConversationPressed;
  final List<Conversation> chatList;

  @override
  Widget build(BuildContext context) {
    final hasChatList = chatList.isNotEmpty;
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
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
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final chatData = chatList[index];
              return ConversationItem(
                  chatData: chatData,
                  onPressed: () {
                    context.push("/chatDetail",
                        extra: {'conversationId': chatData.key});
                  },
                  isLastItem: chatList.length - 1 == index);
            },
            itemCount: chatList.length,
          ),
          if (showViewAllConversation && hasChatList) ...[
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: onSeeConversationListPressed,
              child: Text(
                'View all conversations',
                style: context.textTheme.captionBold.copyWith(
                    color: context.secondaryColor.matterhorn, fontSize: 12),
              ),
            )
          ]
        ],
      ),
    );
  }
}
