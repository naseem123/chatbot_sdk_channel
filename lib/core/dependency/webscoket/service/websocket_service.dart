import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketService {
  WebsocketService({
    String? webSocketURL,
  }) : _webSocketURL = webSocketURL ?? "";

  final String _webSocketURL;
  late IOWebSocketChannel channel;
  late StreamController<Map<String, dynamic>> messageController;

  void initializeControllers() {
    messageController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void connect({
    required Map<String, String> headers,
  }) {
    debugPrint('Connecting to the server...');
    var url = transformURL(headers: headers);
    debugPrint(url);
    channel = IOWebSocketChannel.connect(
      url,
      headers: headers,
      pingInterval: const Duration(seconds: 1),
    );

    channel.stream.listen(
      (event) {
        Map<String, dynamic> message = jsonDecode(event);
        messageController.add(map);
      },
      onDone: () {
        debugPrint('Connection closed');
      },
      onError: (error) {
        debugPrint('Error: $error');
      },
    );
  }

  String transformURL({required Map<String, String> headers}) {
    return "$_webSocketURL?app=${headers['app']}&session_id=${headers['session-id']}&"
        "user_data=e30=";
  }

  void send(String data) {
    if (channel.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    channel.sink.add(data);
  }

  Stream<Map<String, dynamic>> messageUpdates() {
    return messageController.stream;
  }

  void disconnect() {
    if (channel.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    channel.sink.close();

    messageController.close();
    initializeControllers();
  }
}

var map = {
  "conversation_key": "TeCM3zJ1nXm87nRrThkRymfH",
  "message_key": "c28pwGb7umwvx5G38Ns1ccBP",
  "trigger": "2091",
  "path_id": "800acc6e-34ba-4792-9699-9866951599b4",
  "step": "7741dfa5-bd13-4a81-98ea-243f4fc8d469",
  "reply": {
    "element": "button",
    "id": "1b0fc2b4-a808-455b-9590-780f89840b05",
    "label": "Enter input",
    "nextStepUuid": "7741dfa5-bd13-4a81-98ea-243f4fc8d469",
    "pathId": "800acc6e-34ba-4792-9699-9866951599b4"
  },
  "action": "trigger_step"
};
