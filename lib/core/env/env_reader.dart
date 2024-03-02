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

  late String _appId;
  late String _origin;
  late String _apiUrl;

  String getAppID() {
    return _appId;
  }

  void setAppId(String appId) {
    _appId = appId;
  }

  String getBaseUrl() {
    return 'https://$_origin';
  }

  void setBaseUrl(String baseUrl) {
    _origin = baseUrl;
  }

  String getApiUrl() {
    return 'https://$_apiUrl';
  }

  void setApiUrl(String baseUrl) {
    _apiUrl = baseUrl;
  }

  String getWebsocketBaseUrl() {
    return 'wss://$_apiUrl/cable';
  }

  Future<void> init(
      {required String appID,
      required String origin,
      required String apiUrl}) async {
    _appId = appID;
    _origin = origin;
    _apiUrl = apiUrl;
  }
}
