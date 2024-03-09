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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Text(
        message.message,
        style: GoogleFonts.inter(
          color: context.secondaryColor.lightWhite,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}
