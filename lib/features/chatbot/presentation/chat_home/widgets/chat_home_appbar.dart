import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbot/channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: buildLogo(),
              title: Text(
                title,
                style: GoogleFonts.arimo(
                  color: context.secondaryColor.lightWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  if (Platform.isIOS) {
                    Channel.callNativeMethod();
                  } else {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  }
                },
                icon: const Icon(
                  Icons.close,
                  size: 38,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: GoogleFonts.arimo(
                  color: context.secondaryColor.lightWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLogo() {
    if (logo.isEmpty) {
      return const SizedBox.shrink();
    }
    return CachedNetworkImage(
      imageUrl: logo,
      height: 40,
      width: 40,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 84);
}
