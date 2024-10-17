import 'package:flutter/material.dart';

class PasswordProvider extends ChangeNotifier {
  String _password = '';
  String _confirmPassword = '';
  String? _errorMessage;

  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String? get errorMessage => _errorMessage;

  set password(String value) {
    _password = value;
    checkPasswords();
    notifyListeners();
  }

  set confirmPassword(String value) {
    _confirmPassword = value;
    checkPasswords();
    notifyListeners();
  }

  void checkPasswords() {
    if (_password.isEmpty || _confirmPassword.isEmpty) {
      _errorMessage = null;
    } else if (_password != _confirmPassword) {
      _errorMessage = "Password do not match";
    } else {
      _errorMessage = null;
    }
    notifyListeners();
  }
}