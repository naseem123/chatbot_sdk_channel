import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('com.chatbot.channel');

class Channel {
  static void invokeMethod() {
    try {
      _channel.invokeMethod(
        'callNativeMethod',
      );
    } catch (e) {
      if (kDebugMode) {
        print("errro$e");
      }
    }
  }
}
