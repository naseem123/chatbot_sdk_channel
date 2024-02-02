import 'package:flutter/material.dart';

extension StringExtensionEmpty on String? {
  bool get isNullOrEmpty => (this == null || this!.isEmpty);
}

extension StringExtension on String {
  Color get toColor {
    int colorValue = int.parse(replaceAll('#', ''), radix: 16);
    colorValue = 0xFF000000 + colorValue;

    return Color(colorValue);
  }
}
