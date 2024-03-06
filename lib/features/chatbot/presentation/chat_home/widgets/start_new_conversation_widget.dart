import 'dart:io';

import 'package:chatbot/core/extensions/text_style_extension.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartNewConversationWidget extends StatelessWidget {
  const StartNewConversationWidget({
    super.key,
    this.buttonColor,
    required this.onStartConversationPressed,
    required this.onSeePreviousPressed,
    required this.replyTime,
  });

  final String replyTime;
  final VoidCallback onStartConversationPressed;
  final VoidCallback onSeePreviousPressed;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.secondaryColor.whiteSmoke,
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
          Text(
            'Start a conversation',
            style: tn.w6.s18,
          ),
          Text(
            replyTextMap[replyTime] ?? '',
            style: tn.s12.c(context.secondaryColor.gray18),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                height: 45,
                width: 190,
                child: Button.accent(
                  onPressed: onStartConversationPressed,
                  primaryColor: buttonColor,
                  buttonRadius: Platform.isAndroid ? 24 : 12,
                  child: Text(
                    'Start a conversation',
                    style: tn.s16.c(context.secondaryColor.lightWhite),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: onSeePreviousPressed,
                  child: Text(
                    'See previous',
                    style: GoogleFonts.inter(
                      color: context.colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
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

Map<String, dynamic> get replyTextMap => {
  "auto": "The team will respond as soon as possible",
  "minutes": "The team usually responds in minutes",
  "hours": "The team usually responds in a matter of hours",
  "day": "The team usually responds in one day",
  "off": "",
};
