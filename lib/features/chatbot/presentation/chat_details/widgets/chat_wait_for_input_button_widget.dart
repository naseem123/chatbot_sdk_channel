import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWaitForInputButtonWidget extends StatelessWidget {
  const ChatWaitForInputButtonWidget(
      {super.key,
      required this.buttons,
      required this.onUserInputTriggered,
      required this.color});

  final Function(Block) onUserInputTriggered;
  final List<Block> buttons;
  final Color color;

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
                          color: color, borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        button.label,
                        style: GoogleFonts.arimo(
                          color: context.secondaryColor.mostlyBlack,
                        ),
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
