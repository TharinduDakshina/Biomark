import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:biomark/auth/auth_service.dart';
import 'package:biomark/view/screens/home_screen.dart';
import 'package:biomark/view/screens/sign_in_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            return const SignInScreen();
          } else {
            return const HomeScreen();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
