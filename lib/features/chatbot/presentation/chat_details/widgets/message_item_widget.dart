import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    super.key,
    required this.message,
  });

  final String message;

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

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.66),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: context.secondaryColor.gray,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: context.secondaryColor.mostlyBlack,
              ),
        ),
      ),
    );
  }
}
