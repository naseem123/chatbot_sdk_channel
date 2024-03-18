import 'package:cached_network_image/cached_network_image.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBotAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatBotAppbar({
    super.key,
    required this.colorPrimary,
    required this.backButtonPressed,
    required this.title,
    required this.subTitle,
    required this.logo,
  });

  final String title;
  final String subTitle;
  final String logo;
  final Color colorPrimary;

  final VoidCallback backButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(.1),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button.iconButton(
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 22,
                ),
                onPressed: () {
                  backButtonPressed();
                  context.pop();
                },
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildLogo(),
                      const Gap(14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.inter(
                                color: context.secondaryColor.mostlyBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (subTitle.isNotEmpty)
                              Text(
                                subTitle,
                                style: GoogleFonts.inter(
                                  color: context.secondaryColor.mostlyBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    if (logo.isEmpty) {
      return const SizedBox.shrink();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: CachedNetworkImage(
        imageUrl: logo,
        height: 40,
        width: 40,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 70);
}
