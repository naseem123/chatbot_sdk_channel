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
    Widget messageWidget;
    final tStyle = GoogleFonts.arimo(
      color: context.secondaryColor.mostlyBlack,
      fontSize: 16,
      height: 1.5,
    );

    if (message.message.startsWith(sentMessageHead)) {
      messageWidget = RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: sentMessageHead,
              style: tStyle,
            ),
            // Normal text
            TextSpan(
                text: message.message.replaceAll(sentMessageHead, ''),
                style: tStyle.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      );
      Text(
        message.message,
        style: GoogleFonts.arimo(
          color: context.secondaryColor.mostlyBlack,
          fontSize: 16,
          height: 1.5,
        ),
      );
    } else {
      messageWidget = Text(
        message.message,
        style: GoogleFonts.arimo(
          color: context.secondaryColor.mostlyBlack,
          fontSize: 16,
          height: 1.5,
        ),
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: messageWidget,
      ),
    );
  }
}
