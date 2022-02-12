import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom_app_bars/custom_appbar.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final String title;
  const WebViewPage({Key? key, required this.url, this.title = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: WebView(initialUrl: url),
    );
  }
}
