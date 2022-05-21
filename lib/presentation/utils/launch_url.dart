import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes/app_routes.gr.dart';

/// Launches a URL, either in a webview or by using
/// the default browser of the phone, if URL is reachable.
///
/// [url] The url to visit
/// [context] Optional BuildContext, should only be used
/// in cases where [useWebView] != false and want to push
/// a screen containing a WebView
/// [useWebView] Controls whether to use a WebView or visit
/// the url using the default browser
Future<void> launchUrl(
  String url, {
  BuildContext? context,
  bool useWebView = false,
}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    if (useWebView) {
      if (context != null) {
        context.router.push(WebViewRoute(url: url));
        return;
      }
      launchUrl(url, useWebView: true);
    }
    launchUrl(url);
  }
}
