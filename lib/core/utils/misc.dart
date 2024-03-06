import 'dart:io';
import 'dart:math';

String getRandomString({int length = 10}) {
  final random = Random();
  const hexChars = '0123456789ABCDEF';

  StringBuffer buffer = StringBuffer();

  for (int i = 0; i < length; i++) {
    buffer.write(hexChars[random.nextInt(hexChars.length)]);
  }

  return buffer.toString();
}

String getRandomKey({int length = 10}) {
  final random = Random();
  const hexChars = '0123456789abcdefghijklmnopqrstuvwxyz';

  StringBuffer buffer = StringBuffer();

  for (int i = 0; i < length; i++) {
    buffer.write(hexChars[random.nextInt(hexChars.length)]);
  }

  return buffer.toString();
}

bool get isAndroid => Platform.isAndroid;