import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/features/chatbot/model/app_configuration_model.dart';
import 'package:flutter/material.dart';

class ChatbotAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatbotAppbar({super.key, required this.appSettingg});

  final AppSettings appSettingg;

  @override
  Widget build(BuildContext context) {
    final appBarColors = [
      appSettingg.app.customizationColors.primary.toColor,
      appSettingg.app.customizationColors.secondary.toColor
    ];
    print(appBarColors);
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: appBarColors)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(appSettingg.app.name),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 42);
}
