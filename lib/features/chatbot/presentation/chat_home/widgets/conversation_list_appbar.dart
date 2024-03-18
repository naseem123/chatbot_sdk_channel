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
      decoration: BoxDecoration(
        color: context.secondaryColor.lightWhite,
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(.1),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildLogo(context),
              Text(
                title,
                style: context.textTheme.captionBold.copyWith(
                    color: context.secondaryColor.mostlyBlack,
                    fontSize: 18,
                    height: 1.2),
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
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.chevron_left,
        size: 28,
        color: Colors.black,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 84);
}
