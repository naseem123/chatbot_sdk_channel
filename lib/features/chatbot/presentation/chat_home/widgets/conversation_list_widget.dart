import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/conversation_item.dart';
import 'package:chatbot/i18n/app_localization.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate('continue_conversation'),
                style: context.textTheme.captionBold.copyWith(
                  color: context.colorScheme.primary,
                  fontSize: 18,
                ),
              ),
              if (hasChatList)
                IconButtons(
                  onPressed: () => showDeleteConversationConfirmationPopup(
                      context, onDeleteConversationPressed),
                  path: 'assets/icons/reload_icon.svg',
                  height: 14,
                  width: 14,
                ),
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
            const Gap(24),
            InkWell(
              onTap: onSeeConversationListPressed,
              child: Text(
                AppLocalizations.of(context)
                    .translate('view_all_conversations'),
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
