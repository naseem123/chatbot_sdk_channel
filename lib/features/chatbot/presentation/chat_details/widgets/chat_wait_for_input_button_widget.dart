import 'package:chatbot/core/utils/misc.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

class ChatWaitForInputButtonWidget extends StatelessWidget {
  const ChatWaitForInputButtonWidget({
    Key? key,
    required this.buttons,
    required this.onUserInputTriggered,
    required this.color,
  }) : super(key: key);

  final Function(Block) onUserInputTriggered;
  final List<Block> buttons;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin:
            EdgeInsets.only(left: 24, right: 24, bottom: isAndroid ? 16 : 0.0),
        decoration: BoxDecoration(
          color: const Color(0xFFf6f6f6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: buttons.length,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(
            color: Colors.black.withOpacity(.1),
            thickness: 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            final button = buttons[index];
            return InkWell(
              onTap: () => onUserInputTriggered(button),
              child: Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text(button.label,
                    style:
                        context.textTheme.body1Medium.copyWith(color: color)),
              ),
            );
          },
        ),
      ),
    );
  }
}
