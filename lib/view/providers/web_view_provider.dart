import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewProvider with ChangeNotifier {
  late WebViewController _controller;

  WebViewProvider() {
    _initializeController();
  }

  WebViewController get controller => _controller;

  void _initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://www.biomarking.com/"));
  }
}
