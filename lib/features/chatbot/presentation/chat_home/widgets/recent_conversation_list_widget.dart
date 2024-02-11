import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/conversation_item.dart';
import 'package:chatbot/features/chatbot/presentation/chat_home/widgets/delete_recent_conversations.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentConversationListWidget extends StatelessWidget {
  const RecentConversationListWidget({
    Key? key,
    required this.chatList,
  }) : super(key: key);

  final List<Conversation> chatList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
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
                style: GoogleFonts.arimo(
                  color: context.colorScheme.primary,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              IconButtons(
                  onPressed: () =>
                      showDeleteConversationConfirmationPopup(context, () {}),
                  path: 'assets/icons/reload_icon.svg'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final chatData = chatList[index];
                return ConversationItem(
                  chatData: chatData,
                  isLastItem: false,
                );
              },
              itemCount: chatList.length,
            ),
          ),
          InkWell(
            child: Text(
              'view all conversations',
              style: GoogleFonts.arimo(
                color: context.secondaryColor.matterhorn,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                height: 1.3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
