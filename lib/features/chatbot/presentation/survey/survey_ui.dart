import 'dart:async';
import 'dart:convert';

import 'package:chatbot/chatbot_app.dart';
import 'package:chatbot/core/env/env_reader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SurveyUi extends StatefulWidget {
  const SurveyUi({super.key, required, required this.surveyData});

  final String surveyData;

  @override
  State<SurveyUi> createState() => _SurveyUiState();
}

class _SurveyUiState extends State<SurveyUi> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController _mycontroller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Map surveyMap = {};

  @override
  Widget build(BuildContext context) {
    final surveyData = Uri.encodeComponent(jsonEncode(widget.surveyData));
    final url =
        '${providersContext().read(envReaderProvider).getBaseUrl()}/package_iframe/surveys?data=$surveyData';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
          child: Stack(children: [
        WebView(
          backgroundColor: Colors.white,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
          onWebViewCreated: (webviewcontroller) {
            _controller.complete(_mycontroller = webviewcontroller);
          },
          onPageFinished: (string) {
            setState(() {
              isLoading = false;
            });
            _mycontroller.runJavascript('''
        window.addEventListener('message', function(event) {
          chatbotMessageChannel.postMessage(JSON.stringify(event.data));
          }); 
        ''');
          },
          javascriptChannels: {
            JavascriptChannel(
              name: 'chatbotMessageChannel',
              onMessageReceived: (JavascriptMessage message) {
                surveyMap = jsonDecode(message.message);
                Future.delayed(const Duration(milliseconds: 400)).then((value) {
                  context.pop(surveyMap);
                });
              },
            )
          },
        ),
        if (isLoading) const Center(child: CircularProgressIndicator())
      ])),
    );
  }
}
