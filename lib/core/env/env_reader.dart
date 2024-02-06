import 'package:chatbot/core/flavor/flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final envReaderProvider = Provider<EnvReader>((ref) {
  return EnvReader();
});

class EnvReader {
  String getEnvFileName(Flavor flavour) {
    switch (flavour) {
      case Flavor.dev:
        return '.development.env';
      case Flavor.stag:
        return '.stag.env';
      case Flavor.prod:
        return '.prod.env';
      default:
        throw Exception(".env file not found");
    }
  }

  //TODO(naseem): need to refactor. Once the SDK has been setup these values needs to come from the main dynamic arguments

  String getAppID() {
    return 'yB9BJmrcH3bM4CShtMKB5qrw';
  }

  String getBaseUrl() {
    return 'https://test.ca.digital-front-door.stg.gcp.trchq.com';
  }

  String getWebsocketBaseUrl() {
    return 'wss://test.ca.digital-front-door.stg.gcp.trchq.com/cable';
  }
}
