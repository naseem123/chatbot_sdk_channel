import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class FieldPickerScaffold extends StatelessWidget {
  const FieldPickerScaffold({
    super.key,
    required this.child,
    required this.onDone,
  });

  final Widget child;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7).withOpacity(0.8),
            ),
            child: Row(
              children: [
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF007AFF),
                    textStyle: context.textTheme.button!.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  onPressed: onDone,
                  child: const Text('Done'),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: child,
          ),
        ],
      ),
    );
  }
}
