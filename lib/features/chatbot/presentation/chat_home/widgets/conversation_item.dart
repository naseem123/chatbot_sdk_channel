import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbot/features/chatbot/model/conversation_model.dart';
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

/*
{"conversation_key":"5Q5GZv3jJrQKq9KCqPkHtp4z","message_key":"F3g99YMQpKJRPQprFeARZbeL","trigger":"2025","step":"11d8e2ec-f838-45e7-b141-06500abc345b","reply":{"id":"38c8a2a0-e266-4f6d-9fdc-6e2b6b705636","label":"Yes","rules":[{"value":["ED"],"action":"set","target":"conversation","attribute":"tag_list"}],"element":"button","path_id":"7f96451d-268b-4c5e-ae1d-cd0aeed6c638","next_step_uuid":"11d8e2ec-f838-45e7-b141-06500abc345b"},"action":"trigger_step"}


{"command":"message",
"identifier":"{\"app\":\"yB9BJmrcH3bM4CShtMKB5qrw\",\"channel\":\"MessengerEventsChannel\",\"session_id\":\"05u90nkzmBbGpYOg8W8GwA\",\"enc_data\":\"{}\",\"session_value\":null,\"user_data\":\"{}\"}",
"data":"{\"action\":\"trigger_step\",\"trigger\":\"\",\"conversation_key\":\"guXaxqJGBAqtcuSXfpbuoNJG\",\"message_key\":\"TXpX2GFhxwKkfUrLjhxKoCVH\",\"path_id\":\"5bb40c1f-429d-4473-9578-52374c649395\",\"step\":\"adc182b5-07a4-4218-808a-c24c6350e9e1\",\"reply\":{\"element\":\"button\",\"id\":\"0dc3559e-4eab-43d9-ab60-7325219a3f6f\",\"label\":\"Formatted Messages\",\"next_step_uuid\":\"adc182b5-07a4-4218-808a-c24c6350e9e1\",\"path_id\":\"5bb40c1f-429d-4473-9578-52374c649395\"}}"}*/
