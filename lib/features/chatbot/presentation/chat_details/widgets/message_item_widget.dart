import 'dart:convert';

import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draft/flutter_draft.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resources/resources.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    super.key,
    required this.message,
  });

  final MessageUiModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    /* final alignment = (message.senderUserId != userId1)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final color = (message.senderUserId == userId1)
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    final textColor = (message.senderUserId == userId1)
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;
*/
    Widget messageWidget;

    if (message.message.contains("blocks")) {
      messageWidget = SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: DraftTextView.json(
          jsonDecode(message.message),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          defaultStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: context.secondaryColor.mostlyBlack,
                fontSize: 16,
                height: 1.5,
              ),
          onLinkTab: (link) {
            _launchUrl(link);
          },
        ),
      ); //
    } else {
      messageWidget = SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            message.message,
            style: GoogleFonts.arimo(
              color: context.secondaryColor.mostlyBlack,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.9),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(
            3.0,
          ),
        ),
        child: messageWidget,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
