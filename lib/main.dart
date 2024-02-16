import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  providersContext().read(envReaderProvider).init(arguments[0],arguments[1]);

  loadProviders();
  await preference.init();
  runApp(const ChatBotApp());
}
