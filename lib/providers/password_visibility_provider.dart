import 'package:flutter/material.dart';

class PasswordVisibilityProvider extends ChangeNotifier{
  bool _isvisible = true;

  bool get visibility => _isvisible;

  void toggleVisibility() {
    _isvisible = !_isvisible;
    notifyListeners();
  }
}