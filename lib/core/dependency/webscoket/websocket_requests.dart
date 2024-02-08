import 'package:clean_framework/clean_framework_legacy.dart';

abstract class WebsocketRequest extends Request {}

class ConnectWebsocketRequest extends WebsocketRequest {}

class ListenToSocketRequest extends WebsocketRequest {}

class SendMessageToSocketRequest extends WebsocketRequest {
  SendMessageToSocketRequest({
    required this.messageData,
  });

  final String messageData;
}

class DisconnectWebsocketRequest extends WebsocketRequest {}
