import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    required this.chatData,
  });

  final Conversation chatData;

  @override
  Widget build(BuildContext context) {
    final chatIsOpen = chatData.isOpen;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 64,
          child: Row(
            children: [
              Stack(
                children: [
                  if (chatData.assigneeAvatar == null)
                    defaultIcon()
                  else
                    CachedNetworkImage(
                      imageUrl: chatData.assigneeAvatar!,
                      height: 40,
                      width: 40,
                      errorWidget: (context, url, error) {
                        return defaultIcon();
                      },
                    ),
                  if (chatIsOpen)
                    Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                              color: Color(0xFFec3116), shape: BoxShape.circle),
                        ))
                ],
              ),
              const Gap(14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    chatData.assigneeName,
                    style: context.textTheme.captionMedium
                        .copyWith(color: const Color(0xFF4D4C4C), fontSize: 14),
                  ),
                  if (chatIsOpen)
                    const Text('is waiting for your reply')
                  else
                    const Text('Thanks for stopping by!')
                ],
              ),
              const Spacer(),
              Text(
                chatData.lastUpdatedTimeText,
                style: context.textTheme.captionMedium
                    .copyWith(color: const Color(0xFF4D4C4C)),
              )
            ],
          ),
        ),
        const Divider(
          color: Color(0xFFECECEC),
          thickness: 1,
        ),
      ],
    );
  }

  ImageIcons defaultIcon() {
    return const ImageIcons(
      path: 'assets/icons/message_icon.svg',
    );
  }
}
