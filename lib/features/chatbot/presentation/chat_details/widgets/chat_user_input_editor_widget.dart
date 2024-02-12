import 'package:flutter/material.dart';

class ChatUserInputEditorWidget extends StatelessWidget {
  const ChatUserInputEditorWidget({
    super.key,
    required this.textEditingController,
    required this.onMessageEntered,
  });

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
            child: SizedBox(
              height: 60,
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Send Message',
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (textEditingController.text.trim().isNotEmpty) {
                        onMessageEntered(textEditingController.text.trim());
                      }
                    },
                    icon: const Icon(Icons.send),
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
