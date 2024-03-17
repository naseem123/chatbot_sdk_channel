import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbot/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:resources/resources.dart';

class ChatBotAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatBotAppbar({
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
      padding: const EdgeInsets.only(left: 24),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.close,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(24),
                buildLogo(),
                const Gap(12),
                Text(
                  title,
                  style: tn.w6.s20.c(context.secondaryColor.mostlyWhite),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: tn.s16.c(context.secondaryColor.mostlyWhite),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogo() {
    if (logo.isEmpty) {
      return const SizedBox.shrink();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: CachedNetworkImage(
        imageUrl: logo,
        height: 40,
        width: 40,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 160);
}
