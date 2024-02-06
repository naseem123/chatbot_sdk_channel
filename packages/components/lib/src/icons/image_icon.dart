import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageIcons extends StatelessWidget {
  const ImageIcons({required this.path, this.height, this.width});

  final String path;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
    );
  }
}
