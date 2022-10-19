import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom_app_bars/custom_appbar.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final String title;
  const WebViewPage({super.key, required this.url, this.title = ""});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: title,
        closable: true,
      ),
      body: WebView(initialUrl: url),
    );
  }
}
