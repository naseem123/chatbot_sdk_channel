import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  loadProviders();
  await preference.init();

  runApp(const ChatBotApp());
}
