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
