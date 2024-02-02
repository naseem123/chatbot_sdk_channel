import 'package:chatbot/core/flavor/flavor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  String getBaseUrl() {
    return dotenv.get('BASE_URL');
  }
}
