import 'package:biomark/view/widgets/sign_in_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/password_email_provider.dart';
import '../providers/password_visibility_provider.dart';
import '../theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase auth

class RecoveryScreen2 extends StatefulWidget {
  const RecoveryScreen2({super.key});

  @override
  State<RecoveryScreen2> createState() => _RecoveryScreen2State();
}

class _RecoveryScreen2State extends State<RecoveryScreen2> {
  String? userEmail; // Declare userEmail as a nullable variable
  final TextEditingController emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Extract email from the previous screen's arguments
    final arguments = ModalRoute.of(context)?.settings.arguments as String?;
    if (arguments != null) {
      setState(() {
        userEmail = arguments; // Initialize userEmail
        // emailController.text = userEmail ?? ''; // Set email in the controller
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(color: AppTheme.colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reset Password",
                      style: TextStyle(
                          color: AppTheme.colors.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.1,
                    right: screenWidth * 0.1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Create a new password.",
                          style: TextStyle(color: AppTheme.colors.primary),
                        ),
                      )
                    ],
                  ),
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
                          // Email field
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'E-mail',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          Consumer<PasswordEmailProvider>(
                              builder: (context, passwordEmailProvider, child) {
                            return TextFormField(
                              controller: emailController,
                              onChanged: (value) {
                                passwordEmailProvider.email = value;
                              },
                              style: TextStyle(
                                  color: AppTheme.colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  hintText: 'e-mail',
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
                                      color: AppTheme.colors.primary,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.colors.primary,
                                      width: 1,
                                    ),
                                  ),
                                  errorText: passwordEmailProvider.emailError),
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          // New password field
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'New Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          Consumer<PasswordEmailProvider>(
                              builder: (context, passwordEmailProvider, child) {
                            return Consumer<PasswordVisibilityProvider>(builder:
                                (context, passwordVisibilityProvider, child) {
                              return TextFormField(
                                obscureText:
                                    passwordVisibilityProvider.visibility,
                                onChanged: (value) {
                                  passwordEmailProvider.password = value;
                                },
                                decoration: InputDecoration(
                                    hintText: 'New password',
                                    hintStyle: TextStyle(
                                      color: AppTheme.colors.primary
                                          .withOpacity(0.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: AppTheme.colors.light,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: AppTheme.colors.primary,
                                        width: 1,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: AppTheme.colors.primary,
                                        width: 1,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          passwordVisibilityProvider
                                              .toggleVisibility();
                                        },
                                        icon: Icon(passwordVisibilityProvider
                                                .visibility
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        color: AppTheme.colors.primary
                                            .withOpacity(0.5)),
                                    errorText:
                                        passwordEmailProvider.lengthError),
                              );
                            });
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          // Confirm password field
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          Consumer<PasswordEmailProvider>(
                              builder: (context, passwordEmailProvider, child) {
                            return Consumer<PasswordVisibilityProvider>(builder:
                                (context, passwordVisibilityProvider, child) {
                              return TextFormField(
                                obscureText:
                                    passwordVisibilityProvider.visibility,
                                onChanged: (value) {
                                  passwordEmailProvider.confirmPassword = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Confirm password',
                                  hintStyle: TextStyle(
                                    color: AppTheme.colors.primary
                                        .withOpacity(0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.colors.light,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.colors.primary,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: AppTheme.colors.primary,
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
                                              .withOpacity(0.5))),
                                  errorText: passwordEmailProvider.errorMessage,
                                ),
                              );
                            });
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          SignInButton(
                            buttonColor: AppTheme.colors.primary,
                            textColor: AppTheme.colors.secondary,
                            onPressed: () async {
                              await _changePassword(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    final passwordEmailProvider =
        Provider.of<PasswordEmailProvider>(context, listen: false);
    final String newPassword = passwordEmailProvider.password;
    final String confirmPassword = passwordEmailProvider.confirmPassword;
    final String enteredEmail = emailController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar(context, "Please fill both fields", AppTheme.colors.red);
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackBar(context, "Passwords do not match", AppTheme.colors.red);
      return;
    }
    print("$enteredEmail");
    print("$userEmail");
    // Check if the entered email matches the one passed from the previous screen
    if (enteredEmail.isEmpty || enteredEmail != userEmail) {
      _showSnackBar(context, "Email does not match", AppTheme.colors.red);
      return;
    }

    try {
      final firestore = FirebaseFirestore.instance;
      QuerySnapshot query = await firestore
          .collection('users')
          .where('email', isEqualTo: enteredEmail)
          .get();

      if (query.docs.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: enteredEmail);
        _showSnackBar(
          context,
          "Password reset successful. Please check your email.",
          AppTheme.colors.ok,
        );

        Navigator.pushReplacementNamed(context, '/signinscreen');
      } else {
        _showSnackBar(
            context, "No user found with that email.", AppTheme.colors.red);
      }
    } catch (e) {
      _showSnackBar(
        context,
        "Password reset failed: ${e.toString()}",
        AppTheme.colors.red,
      );
    }
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    content: Text(
      message,
    ),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
