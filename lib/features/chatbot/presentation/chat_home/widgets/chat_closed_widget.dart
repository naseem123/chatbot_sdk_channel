import 'package:components/components.dart';
import 'package:flutter/material.dart';

class ChatClosedWidget extends StatelessWidget {
  const ChatClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
            'We are currently closed',
            style: context.textTheme.captionBold.copyWith(
              color: context.colorScheme.primary,
              fontSize: 19,
            ),
          ),
          Text(
            'We’ll be back at 12:00 AM (AST)',
            style: context.textTheme.captionRegular.copyWith(
              color: context.colorScheme.primary,
              fontSize: 13,
            ),
          ),
          const ImageIcons(path: 'assets/icons/message_icon.svg')
        ],
      ),
    );
  }
}
