import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/core/widgets/draft_view/view/draft_text_view.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
import 'package:chatbot/i18n/app_localization.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
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
      onTap: onPressed,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
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
                              width: 50.0,
                              height: 50.0,
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
                            Text(
                              chatData.assigneeName,
                              style: context.textTheme.captionMedium.copyWith(
                                  color: context.secondaryColor.mostlyBlack,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            if (chatIsOpen)
                              Text(
                                AppLocalizations.of(context)
                                    .translate('waiting_for_reply'),
                                style: context.textTheme.captionRegular
                                    .copyWith(
                                        color: context.secondaryColor.gray18,
                                        fontSize: 12),
                              )
                            else if (!chatData.lastMessage.message
                                .serializedContent.isNullOrEmpty)
                              Expanded(
                                child: DraftTextView.json(
                                  jsonDecode(chatData
                                      .lastMessage.message.serializedContent!),
                                  defaultStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: context.secondaryColor.gray18,
                                        fontSize: 18,
                                        height: 1.5,
                                      ),
                                ),
                              )
                            else
                              Text(
                                AppLocalizations.of(context)
                                    .translate('thanks_for_stopping_by'),
                                style: context.textTheme.captionRegular
                                    .copyWith(
                                        color: context.secondaryColor.gray18,
                                        fontSize: 12),
                              ),
                            Text(
                              chatData.lastUpdatedTimeText,
                              style: context.textTheme.captionRegular.copyWith(
                                  color: context.secondaryColor.graniteGray),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFA7A7A7),
                size: 32,
              )
            ],
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
      width: 50,
      height: 50,
    );
  }
}
