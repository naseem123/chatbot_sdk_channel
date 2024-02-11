import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            'Start a conversation',
            style: GoogleFonts.arimo(
              color: context.colorScheme.primary,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          Text(
            'The team will respond as soon as possible',
            style: GoogleFonts.arimo(
              color: context.secondaryColor.gray52,
              fontSize: 13,
              fontWeight: FontWeight.normal,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
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
                    style: GoogleFonts.arimo(
                      color: context.colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.3,
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
                    style: GoogleFonts.arimo(
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
