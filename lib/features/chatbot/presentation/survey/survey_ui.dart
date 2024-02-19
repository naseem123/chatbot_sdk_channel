import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class SurveyUi extends StatefulWidget {
  const SurveyUi({super.key, required, required this.surveyData});

  final Map<String, dynamic> surveyData;

  @override
  State<SurveyUi> createState() => _SurveyUiState();
}

class _SurveyUiState extends State<SurveyUi> {
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
  }

  Map surveyMap = {};

  @override
  Widget build(BuildContext context) {
    final surveyData = Uri.encodeComponent(jsonEncode(widget.surveyData));
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(
                  'https://test.ca.digital-front-door.stg.gcp.trchq.com/package_iframe/surveys?data=$surveyData'))),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
            _webViewController?.addJavaScriptHandler(
              handlerName: 'onMessageReceived',
              callback: (result) {
                log('Message received from JavaScript: $result');

                surveyMap = result[0];
                Future.delayed(const Duration(milliseconds: 600)).then((value) {
                  context.pop(surveyData);
                });

                // Handle the result from JavaScript here
              },
            );
          },
          onLoadStop: (controller, url) async {
            // Inject JavaScript code to set up a listener for post messages

            print("load stop called");
            await controller.evaluateJavascript(source: '''
          window.addEventListener('message', function(event) {
           window.flutter_inappwebview.callHandler('onMessageReceived', event.data);
            if (event.data && event.data.status == 'OK') {
              var result = event.data.result;
              // Handle the result here in Flutter
              window.flutter_inappwebview.callHandler('onMessageReceived', result);
            }
          });
        ''');
          },
        ),
      ),
    );
  }
}
