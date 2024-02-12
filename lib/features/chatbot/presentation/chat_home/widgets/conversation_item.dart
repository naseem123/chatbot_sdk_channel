import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draft/flutter_draft.dart';
import 'package:gap/gap.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    required this.chatData,
    this.onPressed,
    required this.isLastItem,
  });

  final bool isLastItem;
  final Conversation chatData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final chatIsOpen = chatData.isOpen;

    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Column(
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
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              chatData.assigneeAvatar!,
                            ),
                          ),
                        ),
                      ),
                    if (chatIsOpen)
                      Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                                color: Color(0xFFec3116),
                                shape: BoxShape.circle),
                          ))
                  ],
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            chatData.assigneeName,
                            style: context.textTheme.captionMedium.copyWith(
                                color: context.secondaryColor.matterhorn,
                                fontSize: 14),
                          ),
                          const Spacer(),
                          Text(
                            chatData.lastUpdatedTimeText,
                            style: context.textTheme.captionMedium.copyWith(
                                color: context.secondaryColor.matterhorn),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      if (chatIsOpen)
                        const Text('is waiting for your reply')
                      else if (!chatData
                          .lastMessage.message.serializedContent.isNullOrEmpty)
                        Expanded(
                          child: DraftTextView.json(
                            jsonDecode(chatData
                                .lastMessage.message.serializedContent!),
                            defaultStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: context.secondaryColor.mostlyBlack,
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                          ),
                        )
                      else
                        const Text('Thanks for stopping by!')
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isLastItem)
            const Divider(
              color: Color(0xFFECECEC),
              thickness: 1,
            ),
        ],
      ),
    );
  }

  ImageIcons defaultIcon() {
    return const ImageIcons(
      path: 'assets/icons/message_icon.svg',
    );
  }
}
