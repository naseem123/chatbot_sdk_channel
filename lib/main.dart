import 'package:chatbot/channel.dart';
import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  Channel();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  final appID = arguments.isEmpty ? "yB9BJmrcH3bM4CShtMKB5qrw" : arguments[0];
  final origin = arguments.isEmpty
      ? "test.ca.digital-front-door.stg.gcp.trchq.com"
      : arguments[1];

  providersContext().read(envReaderProvider).init(appID, origin);

  loadProviders();
  await preference.init();
  runApp(const ChatBotApp());
}
