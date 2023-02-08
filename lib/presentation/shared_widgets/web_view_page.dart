import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom_app_bars/custom_appbar.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  const WebViewPage({super.key, required this.url, this.title = ""});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  late final ValueNotifier<bool> _loading;
  late final ValueNotifier<bool> _error;

  @override
  void initState() {
    super.initState();
    _loading = ValueNotifier(false);
    _error = ValueNotifier(false);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => _loading.value = true,
          onPageFinished: (_) => _loading.value = false,
          onWebResourceError: (_) {
            _error.value = true;
            _loading.value = false;
          },
        ),
      );

    _loadUrl();
  }

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  void _loadUrl() {
    _error.value = false;
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: widget.title,
        closable: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          ValueListenableBuilder<bool>(
            valueListenable: _loading,
            builder: (context, loading, _) {
              if (!loading) return const SizedBox.shrink();

              return Align(child: CircularProgressIndicator());
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _error,
            builder: (context, error, _) {
              if (!error) return const SizedBox.shrink();

              return Align(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("No internet connection!!"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _loadUrl,
                      child: Text("Retry"),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
