import 'package:chatbot/features/chatbot/domain/chatbot_use_case.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resources/resources.dart';

class SelfReplyMessageWidget extends StatelessWidget {
  const SelfReplyMessageWidget({
    super.key,
    required this.message,
  });

  final MessageUiModel message;

  @override
  Widget build(BuildContext context) {
    final isReplyMessage = message.message.startsWith(sentMessageHead);
    Widget messageWidget;
    final tStyle = GoogleFonts.inter(
      color: context.secondaryColor.mostlyBlack,
      fontSize: 16,
      height: 1.5,
    );

    if (isReplyMessage) {
      messageWidget = RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: sentMessageHead,
              style: tStyle,
            ),
            TextSpan(
                text: message.message.replaceAll(sentMessageHead, ''),
                style: tStyle.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Text(
          message.message,
          style: GoogleFonts.arimo(
            color: context.secondaryColor.lightWhite,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFFf9f9f9),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: messageWidget,
    );
  }
}
