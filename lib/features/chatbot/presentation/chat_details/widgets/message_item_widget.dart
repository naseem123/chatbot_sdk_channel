import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbot/core/extensions/date_extensions.dart';
import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/core/widgets/draft_view/view/draft_text_view.dart';
import 'package:chatbot/features/chatbot/domain/chatbot_util_enums.dart';
import 'package:chatbot/features/chatbot/model/mesasge_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resources/resources.dart';
import 'package:url_launcher/url_launcher.dart';

import 'self_reply_message_widget.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    super.key,
    required this.message,
    required this.secondaryColor,
  });

  final MessageUiModel message;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);

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
    final isBot = message.messageSenderType == MessageSenderType.bot;

    if (message.message.contains("blocks")) {
      log("message = $message");
      messageWidget = SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DraftTextView.json(
            jsonDecode(message.message),
            padding: const EdgeInsets.symmetric(horizontal: 16),
              secondaryColor:secondaryColor,
            defaultStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: context.secondaryColor.mostlyBlack,
                  fontSize: 18,
                  height: 1.5,
                ),
            onLinkTab: (link) {
              _launchUrl(link);
            },
          ),
        ),
      ); //
    } else {
      if (isBot) {
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
      } else {
        messageWidget = SelfReplyMessageWidget(message: message);
      }
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        if (isBot && message.imageUrl.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    message.imageUrl,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
              borderRadius: getBorderRadius(isBot),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                messageWidget,
                if (isBot)
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      message.createdAt.toDate.timeAgo,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.arima(
                          color: context.secondaryColor.gray52, fontSize: 10),
                    ),
                  )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  BorderRadius getBorderRadius(bool isBot) {
    if (isBot) {
      return const BorderRadius.only(
        topLeft: Radius.circular(3),
        bottomRight: Radius.circular(3),
        topRight: Radius.circular(3),
      );
    }
    return BorderRadius.circular(3.0);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
