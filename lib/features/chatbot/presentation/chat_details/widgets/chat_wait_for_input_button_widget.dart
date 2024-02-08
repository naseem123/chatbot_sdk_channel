import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:flutter/material.dart';

class ChatWaitForInputButtonWidget extends StatelessWidget {
  const ChatWaitForInputButtonWidget(
      {super.key, required this.buttons, required this.onUserInputTriggered});

  final Function(Block) onUserInputTriggered;
  final List<Block> buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: buttons.length,
          itemBuilder: (BuildContext context, int index) {
            final button = buttons[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      onUserInputTriggered(button);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        button.label,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}