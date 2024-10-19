import 'package:biomark/view/providers/password_visibility_provider.dart';
import 'package:biomark/view/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biomark/auth/auth_service.dart';
import '../theme/app_theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty && password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Email and password cannot be empty"),
            backgroundColor: AppTheme.colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return;
    } else if (email.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("E-mail cannot be empty"),
            backgroundColor: AppTheme.colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return;
    } else if (password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Password cannot be empty"),
            backgroundColor: AppTheme.colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return;
    }

    AuthService authService = AuthService();
    AuthResponse response = await authService.signInWithEmailAndPassword(email, password);

    if (response.userCredential != null) {
      if (mounted) {
        Navigator.pushNamed(context, '/homescreen');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.errorMessage ?? "Sign in failed. Please try again."),
            backgroundColor: AppTheme.colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(color: AppTheme.colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 80,
                    child: Image.asset(
                      'assets/images/biomark_logo_black.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: AppTheme.colors.primary,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.1,
                          right: screenWidth * 0.1,
                          top: 5),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              textAlign: TextAlign.start,
                              'E-mail',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                return "Enter a valid e-mail address";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'e-mail',
                              hintStyle: TextStyle(
                                color: AppTheme.colors.primary.withOpacity(0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: AppTheme.colors.primary,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: AppTheme.colors.black,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppTheme.colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              textAlign: TextAlign.start,
                              'Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          Consumer<PasswordVisibilityProvider>(builder:
                              (context, passwordVisibilityProvider, child) {
                            return TextFormField(
                              controller: _passwordController,
                              obscureText:
                                  passwordVisibilityProvider.visibility,
                              decoration: InputDecoration(
                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                    color: AppTheme.colors.primary
                                        .withOpacity(0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.colors.primary,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        passwordVisibilityProvider
                                            .toggleVisibility();
                                      },
                                      icon: Icon(
                                        passwordVisibilityProvider.visibility
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppTheme.colors.primary
                                            .withOpacity(0.5),
                                      ))),
                            );
                          }),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/recoveryscreen1');
                                  },
                                  child: Text(
                                    "Lost account?",
                                    style: TextStyle(
                                      color: AppTheme.colors.primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SignInButton(
                            buttonColor: AppTheme.colors.primary,
                            textColor: AppTheme.colors.secondary,
                            onPressed: _signIn,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style:
                                      TextStyle(color: AppTheme.colors.primary),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/signupscreen');
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.colors.primary),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
