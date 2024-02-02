import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/core/flavor/flavor.dart';
import 'package:chatbot/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  final envReader = providersContext().read(envReaderProvider);
  final envFile = envReader.getEnvFileName(Flavor.prod);
  await dotenv.load(fileName: envFile);

  loadProviders();
  await preference.init();

  runApp(const ChatBotApp());
}
