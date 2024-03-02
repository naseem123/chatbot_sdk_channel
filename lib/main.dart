import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:chatbot/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String novScotiaAppID = "XnA6d2mEejaov78UETAzM5uj";
const String novScotiaOrigin =
    "app-digitalfrontdoor-dev.apps.ext.novascotia.ca";
const String novScotiaApiUrl = "test.ca.one-stop-talk.sbx.gcp.trchq.com";

const String stagingAppID = "yB9BJmrcH3bM4CShtMKB5qrw";
const String stagingOrigin = "test.ca.digital-front-door.stg.gcp.trchq.com";
const String stagingApiUrl = "test.ca.digital-front-door.stg.gcp.trchq.com";

const String appIDLocal = stagingAppID; // novScotiaAppID; //;
const String originLocal = stagingOrigin; // novScotiaOrigin; //
const String apiUrlLocal = stagingApiUrl; // novScotiaApiUrl;//

void main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  final appID = arguments.isEmpty ? appIDLocal : arguments[0];
  final origin = arguments.isEmpty ? originLocal : arguments[1];
  final apiUrl = arguments.isEmpty ? apiUrlLocal : arguments[2];

  providersContext()
      .read(envReaderProvider)
      .init(appID: appID, origin: origin, apiUrl: apiUrl);

  loadProviders();
  await preference.init();
  runApp(const ChatBotApp());
}
