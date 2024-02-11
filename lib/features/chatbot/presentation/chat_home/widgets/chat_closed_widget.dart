import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatClosedWidget extends StatelessWidget {
  const ChatClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
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
            'We are currently closed',
            style: GoogleFonts.arimo(
              color: context.colorScheme.primary,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          Text(
            'We’ll be back at 12:00 AM (AST)',
            style: GoogleFonts.arimo(
              color: context.colorScheme.primary,
              fontSize: 13,
              fontWeight: FontWeight.normal,
              height: 1.5,
            ),
          ),
          const ImageIcons(path: 'assets/icons/message_icon.svg')
        ],
      ),
    );
  }
}
