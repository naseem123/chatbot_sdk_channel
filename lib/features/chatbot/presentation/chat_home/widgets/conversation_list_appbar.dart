import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resources/resources.dart';

class ConversationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ConversationAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.logo = '',
    required this.colorPrimary,
  });

  final String title, subtitle;
  final String logo;
  final Color colorPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorPrimary),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLogo(context),
              Text(
                title,
                style: context.textTheme.captionBold.copyWith(
                  color: context.secondaryColor.lightWhite,
                  fontSize: 22,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right:10.0),
                child: IconButton(
                  onPressed: () {
                    //TODO(naseem) : need to exit from the bot once SDK setup is complete
                    // Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 38,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo(BuildContext context) {
    return IconButton(
      onPressed: context.pop,
      icon: const Icon(
        Icons.chevron_left,
        size: 38,
        color: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 84);
}
