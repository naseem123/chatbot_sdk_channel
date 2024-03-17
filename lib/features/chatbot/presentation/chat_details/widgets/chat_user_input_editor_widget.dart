import 'package:chatbot/i18n/app_localization.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

class ChatUserInputEditorWidget extends StatelessWidget {
  const ChatUserInputEditorWidget({
    super.key,
    required this.textEditingController,
    required this.onMessageEntered,
    required this.colorSecondary,
  });

  final Color colorSecondary;

  final TextEditingController textEditingController;
  final Function(String) onMessageEntered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          /*  IconButton(
            onPressed: () {
// TODO: Send an image
            },
            icon: const Icon(Icons.attach_file),
          ),*/
          Expanded(
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                  color: context.secondaryColor.ligthRed,
                  borderRadius: BorderRadius.circular(32)),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  filled: false,
                  fillColor: Colors.white,
                  hintText: AppLocalizations.of(context)
                      .translate('type_your_message'),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (textEditingController.text.trim().isNotEmpty) {
                        onMessageEntered(textEditingController.text.trim());
                      }
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.send,
                      size: 26,
                      color: colorSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
