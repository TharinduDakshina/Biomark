import 'package:flutter/material.dart';

class SplashScreenProvider extends ChangeNotifier {
  bool _isSplashCompleted = false;
  bool get isSplashCompleted => _isSplashCompleted;

  void completeSplash(){
    _isSplashCompleted = true;
    notifyListeners();
  }
}