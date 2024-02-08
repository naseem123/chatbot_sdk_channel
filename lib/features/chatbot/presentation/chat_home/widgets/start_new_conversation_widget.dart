import 'package:components/components.dart';
import 'package:flutter/material.dart';

class StartNewConversationWidget extends StatelessWidget {
  const StartNewConversationWidget({
    super.key,
    this.buttonColor,
    required this.onStartConversationPressed,
    required this.onSeePreviousPressed,
  });

  final VoidCallback onStartConversationPressed;
  final VoidCallback onSeePreviousPressed;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
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
          Text(
            'Start a conversation',
            style: context.textTheme.captionBold.copyWith(
              color: context.colorScheme.primary,
              fontSize: 19,
            ),
          ),
          Text(
            'The team will respond as soon as possible',
            style: context.textTheme.captionRegular.copyWith(
              color: context.secondaryColor.gray52,
              fontSize: 13,
            ),
          ),
          const ImageIcons(path: 'assets/icons/message_icon.svg'),
          Row(
            children: [
              SizedBox(
                height: 42,
                width: 200,
                child: Button.accent(
                  onPressed: onStartConversationPressed,
                  primaryColor: buttonColor,
                  child: Text(
                    'Start a conversation',
                    style: context.textTheme.captionBold.copyWith(
                      color: context.secondaryColor.lightWhite,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: onSeePreviousPressed,
                  child: Text(
                    'See previous',
                    style: context.textTheme.captionBold.copyWith(
                      color: context.colorScheme.primary,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
