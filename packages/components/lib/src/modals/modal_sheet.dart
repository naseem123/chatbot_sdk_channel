import 'package:components/src/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class ModalSheet<T> extends StatelessWidget {
  const ModalSheet({
    super.key,
    required this.body,
    required this.action,
    this.secondaryAction,
    this.icon,
    this.title,
    this.isDismissible = true,
    this.isDestructiveButton = false,
  });

  final Widget body;
  final ModalAction action;
  final ModalAction? secondaryAction;
  final Widget? icon;
  final Widget? title;
  final bool isDismissible;
  final bool isDestructiveButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: icon,
            ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DefaultTextStyle(
                style: context.textTheme.titleMedium!,
                child: title!,
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: DefaultTextStyle(
              style: context.textTheme.body1Regular,
              child: body,
            ),
          ),
          const SizedBox(height: 24),
          if (isDestructiveButton)
            Button.destructive(
              state: action.state,
              onPressed: action.onPressed,
              child: Text(action.label),
            )
          else
            Button(
              state: action.state,
              onPressed: action.onPressed,
              child: Text(action.label),
            ),
          if (secondaryAction != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: context.textTheme.titleMedium,
                ),
                onPressed: action.state == ButtonState.active
                    ? secondaryAction!.onPressed
                    : null,
                child: Text(secondaryAction!.label),
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<T?> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => this,
    );
  }
}

class ModalAction {
  ModalAction({
    required this.label,
    required this.onPressed,
    this.state = ButtonState.active,
  });

  factory ModalAction.dismiss({
    required BuildContext context,
    required String label,
  }) {
    return ModalAction(
      label: label,
      onPressed: () => Navigator.pop(context),
    );
  }

  final String label;
  final VoidCallback onPressed;
  final ButtonState state;
}
