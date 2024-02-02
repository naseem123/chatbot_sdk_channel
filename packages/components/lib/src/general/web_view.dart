import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatelessWidget {
  const AppWebView({super.key, required this.url, this.onProgress});
  final String url;
  final ValueChanged<int>? onProgress;
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      onProgress: onProgress,
    );
  }
}
