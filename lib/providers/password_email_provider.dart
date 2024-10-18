import 'package:flutter/material.dart';

class PasswordEmailProvider extends ChangeNotifier {
  String _password = '';
  String _confirmPassword = '';
  String? _errorMessage;
  String? _lengthError;
  String? _emailError;

  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String? get errorMessage => _errorMessage;
  String? get lengthError => _lengthError;
  String? get emailError => _emailError;

  set email(String value) {
    if (value.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      _emailError = "Please enter a valid e-mail";
    }else{
      _emailError = null;
    }
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    if (_password.length < 5) {
      _lengthError = "Password should have more than 5 characters";
    } else {
      _lengthError = null;
    }
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
      _errorMessage = "Passwords do not match";
    } else {
      _errorMessage = null;
    }
    notifyListeners();
  }
}
