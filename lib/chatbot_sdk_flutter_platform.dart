import 'package:flutter/services.dart';

class ChatBotSDKFlutterPlatform {
  final methodChannel = const MethodChannel('chatbot_channel');

  ChatBotSDKFlutterPlatform() {
    methodChannel.setMethodCallHandler(methodHandler);
  }

  Future<void> methodHandler(MethodCall call) async {
    switch (call.method) {
      case "initialize":
        break;
    }
  }
}
