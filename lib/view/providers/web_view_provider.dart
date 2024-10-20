import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewProvider extends ChangeNotifier {
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

  void reloadWebView() {
    _controller.loadRequest(Uri.parse("https://www.biomarking.com/"));
  }

  void resetController() {
    _initializeController();
    notifyListeners();
  }
}
