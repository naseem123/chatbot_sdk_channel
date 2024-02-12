import 'package:flutter/material.dart';

extension StringExtensionEmpty on String? {
  bool get isNullOrEmpty => (this == null || this!.isEmpty);
}

extension StringExtension on String {
  Color get toColor {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('FF');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  DateTime get toDate {
    return DateTime.tryParse(this) ?? DateTime.now();
  }
}
