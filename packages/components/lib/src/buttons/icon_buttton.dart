import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconButtons extends StatelessWidget {
  const IconButtons(
      {required this.onPressed, required this.path, this.height, this.width});

  final String path;
  final VoidCallback onPressed;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        path,
        height: height,
        width: width,
        color: Theme.of(context).appBarTheme.iconTheme!.color,
      ),
      onPressed: onPressed.call,
    );
  }
}
