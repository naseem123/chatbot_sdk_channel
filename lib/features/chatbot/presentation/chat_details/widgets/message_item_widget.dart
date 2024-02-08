import 'dart:convert';

import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draft/flutter_draft.dart';
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

    if(message.message.contains("blocks")) {
      messageWidget = DraftTextView.json(
        jsonDecode(message.message),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        defaultStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: context.secondaryColor.mostlyBlack,
        ),
        onLinkTab: (link){
          _launchUrl(link);
        },
      ); //
    }
    else{
      messageWidget = Text(
        message.message,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: context.secondaryColor.mostlyBlack,
        ),
      );
    }

    return Card(
      color: Colors.white,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(maxWidth: size.width * 0.9),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
          ),
          child: messageWidget,
        ),
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
