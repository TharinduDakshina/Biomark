import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  User? get currentUser {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
