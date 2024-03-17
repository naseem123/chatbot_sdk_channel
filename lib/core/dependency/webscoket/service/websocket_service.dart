import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketService {
  WebsocketService({
    String? webSocketURL,
  }) : _webSocketURL = webSocketURL ?? "";

  final String _webSocketURL;
  late IOWebSocketChannel channel;
  late StreamController<Map<String, dynamic>> messageController;
  late Map<String, String> _headers;
  void initializeControllers() {
    messageController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void connect({
    required Map<String, String> headers,
  }) {
    debugPrint('Connecting to the server...');
    var url = transformURL(headers: headers);
    _headers = headers;
    debugPrint(url);
    channel = IOWebSocketChannel.connect(
      url,
      headers: headers,
      pingInterval: const Duration(seconds: 10),
    );

    channel.stream.listen(
      (event) {
        Map<String, dynamic> message = jsonDecode(event);
        if (messageController.isClosed) {
          return;
        }
        if (message['type'] != "ping") {
          _MessageLogger(endpoint: _webSocketURL, message: message);
        }
        if (message['type'] != "ping" && message['type'] != "welcome") {
          if (message['type'] == "confirm_subscription") {
            messageController.add(message);
          } else {
            messageController.add(message['message']);
          }
        }
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
    return "$_webSocketURL?app=${headers['app']}&session_id=${headers['session-id']}&user_data=e30=";
  }

  void send(String data) {
    if (channel.closeCode != null) {
      debugPrint('Not connected');
      connect(headers: _headers);
      return;
    }
    log("SENDING MESSAGE");
    log(data);
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
  }
}

class _MessageLogger extends NetworkLogger {
  _MessageLogger({
    required this.endpoint,
    required this.message,
  });

  final String endpoint;
  final Map<String, dynamic> message;

  @override
  void initialize() {
    printHeader('****CHATBOT RESPONSE*****', endpoint);

    _printData();
    printFooter();
  }

  void _printData() {
    final data = message;
    printCategory('Data');
    printInLines(prettyMap(data));
  }
}
