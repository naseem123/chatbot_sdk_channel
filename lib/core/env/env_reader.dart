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

  late String _appId ;
  late String _origin ;

  //TODO(naseem): need to refactor. Once the SDK has been setup these values needs to come from the main dynamic arguments

  String getAppID() {
    return _appId;
  }

  void setAppId(String appId){
    _appId = appId;
  }

  String getBaseUrl() {
    return 'https://$_origin';
  }

  void setBaseUrl(String baseUrl){
    _origin = baseUrl;
  }

  String getWebsocketBaseUrl() {
    return 'wss://$_origin/cable';
  }

  Future<void> init(String appID, String origin) async {
    _appId = appID;
    _origin = origin;
  }



}

