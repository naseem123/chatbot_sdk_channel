import 'package:flutter/material.dart';

class ChatBotAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatBotAppBar({
    super.key,
    required this.appBarColor,
    required this.title,
  });

  final Color appBarColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 42);
}
