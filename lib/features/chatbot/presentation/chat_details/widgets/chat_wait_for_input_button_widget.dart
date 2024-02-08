import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:flutter/material.dart';

class ChatWaitForInputButtonWidget extends StatelessWidget {
  const ChatWaitForInputButtonWidget({super.key, required this.buttons, required this.onUserInputTriggered});

  final Function(Block) onUserInputTriggered;
  final List<Block> buttons;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index){
      final button = buttons[index];
      return Container(
        padding: const EdgeInsets.all(12),
        child: Text(button.label,),
      );
    });
  }
}
