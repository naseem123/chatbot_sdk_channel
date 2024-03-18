import 'dart:io';

import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/core/extensions/text_style_extension.dart';
import 'package:chatbot/i18n/app_localization.dart';
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
            AppLocalizations.of(context).translate('start_conversation'),
            style: tn.w6.s18,
          ),
          Text(
            replyTextMap(context)[replyTime] ?? '',
            style: tn.s12.c(context.secondaryColor.gray18),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                height:
                    providersContext().read(envReaderProvider).getLang() == 'fr'
                        ? 50
                        : 45,
                width: 190,
                child: Button.accent(
                  onPressed: onStartConversationPressed,
                  primaryColor: buttonColor,
                  buttonRadius: Platform.isAndroid ? 24 : 12,
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('start_conversation'),
                    style: tn.s16.c(context.secondaryColor.lightWhite),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height:
                      providersContext().read(envReaderProvider).getLang() ==
                              'fr'
                          ? 50
                          : 45,
                  child: Button.accent(
                    onPressed: onStartConversationPressed,
                    primaryColor: buttonColor,
                    buttonRadius: Platform.isAndroid ? 24 : 12,
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('start_conversation'),
                      textAlign: TextAlign.center,
                      style: tn.s16.c(context.secondaryColor.lightWhite),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: onSeePreviousPressed,
                  child: Text(
                    AppLocalizations.of(context).translate('see_previous'),
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

Map<String, dynamic> replyTextMap(BuildContext context) {
  return {
    "auto": AppLocalizations.of(context).translate('reply_time_auto'),
    "minutes": AppLocalizations.of(context).translate('reply_time_minutes'),
    "hours": AppLocalizations.of(context).translate('reply_time_hours'),
    "day": AppLocalizations.of(context).translate('reply_time_day'),
    "off": "",
  };
}
