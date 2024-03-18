import 'dart:convert';

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

import 'clipper/chat_right_clipper.dart';
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
    Widget messageWidget;
    final isBot = message.messageSenderType == MessageSenderType.bot;

    if (message.message.contains("blocks")) {
      print('MessageItemWidget.build ++ ${message.message}');
      messageWidget = SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DraftTextView.json(
            jsonDecode(message.message),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            secondaryColor: secondaryColor,
            defaultStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: context.secondaryColor.mostlyBlack,
                  fontSize: 16,
                  height: 1.5,
                ),
            onLinkTab: _launchUrl,
          ),
        ),
      ); //
    } else {
      print('MessageItemWidget.build == ${message.message}');

      if (isBot) {
        messageWidget = Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            message.message,
            style: GoogleFonts.inter(
              color: isBot
                  ? context.secondaryColor.mostlyBlack
                  : context.secondaryColor.lightWhite,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        );
      } else {
        messageWidget = SelfReplyMessageWidget(message: message);
      }
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isBot && message.imageUrl.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    margin: const EdgeInsets.only(bottom: 0),
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
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                  margin: const EdgeInsets.only(
                      left: 5, right: 8, top: 10, bottom: 8),
                  alignment:
                      !isBot ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomPaint(
                        painter: ChatBubble(
                          isOwn: !isBot,
                          color:
                              isBot ? const Color(0xFFE9E9E9) : secondaryColor,
                        ),
                        child: messageWidget,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (message.createdAt.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: Text(
                message.createdAt.toDate.timeAgo,
                textAlign: isBot ? TextAlign.start : TextAlign.end,
                style: GoogleFonts.inter(
                  color: context.secondaryColor.gray52,
                  fontSize: 10,
                ),
              ),
            )
        ],
      ),
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
