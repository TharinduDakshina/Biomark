import 'package:firebase_auth/firebase_auth.dart';

class AuthResponse {
  final UserCredential? userCredential;
  final String? errorMessage;

  AuthResponse({this.userCredential, this.errorMessage});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResponse> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return AuthResponse(userCredential: userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Incorrect e-mail. Please try again.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please try again.';
      } else {
        errorMessage = 'Sign In failed. Please try again.';
      }
      return AuthResponse(errorMessage: errorMessage);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
