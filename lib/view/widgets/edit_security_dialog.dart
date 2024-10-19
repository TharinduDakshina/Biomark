import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Assuming Firebase is used for auth
import '../providers/password_email_provider.dart';
import '../providers/password_visibility_provider.dart';
import '../theme/app_theme.dart';

class EditSecurityDialog extends StatelessWidget {
  final String userEmailPrev;
  const EditSecurityDialog({super.key, required this.userEmailPrev});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 1,
      title: Text(
        'Enter Password',
        style: TextStyle(
          color: AppTheme.colors.primary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      shadowColor: AppTheme.colors.black,
      surfaceTintColor: AppTheme.colors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: AppTheme.colors.primary,
          width: 2,
        ),
      ),
      content: Consumer<PasswordEmailProvider>(
        builder: (context, passwordEmailProvider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<PasswordVisibilityProvider>(
                builder: (context, passwordVisibilityProvider, child) {
                  return TextFormField(
                    obscureText: passwordVisibilityProvider.visibility,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: AppTheme.colors.primary),
                      hintStyle: TextStyle(
                        color: AppTheme.colors.primary.withOpacity(0.5),
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
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          passwordVisibilityProvider.toggleVisibility();
                        },
                        icon: Icon(passwordVisibilityProvider.visibility
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: AppTheme.colors.primary.withOpacity(0.5),
                      ),
                    ),
                    onChanged: (value) {
                      passwordEmailProvider.password = value;
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
      actions: [
        SizedBox(
          width: 92,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: AppTheme.colors.red, width: 1.5),
              elevation: 0,
              foregroundColor: AppTheme.colors.red,
              backgroundColor: AppTheme.colors.secondary,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            child: const Text('Cancel'),
          ),
        ),
        SizedBox(
          width: 92,
          child: ElevatedButton(
            onPressed: () async {
              bool isPasswordCorrect = await _verifyPassword(context);
              if (isPasswordCorrect) {
                Navigator.pop(context);
                _showEditableFields(context);
              } else {
                _showSnackbar(context, 'Incorrect Password.', AppTheme.colors.red);
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: AppTheme.colors.secondary,
              backgroundColor: AppTheme.colors.primary,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.colors.secondary,
              ),
            ),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }

  Future<bool> _verifyPassword(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final passwordProvider = Provider.of<PasswordEmailProvider>(context, listen: false);

    try {
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: passwordProvider.password,
      );
      await user.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _showEditableFields(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer2<PasswordEmailProvider, PasswordVisibilityProvider>(
          builder: (context, passwordEmailProvider, visibilityProvider, child) {
            passwordEmailProvider.email = currentUser?.email ?? '';

            return AlertDialog(
              title: Text(
                'New Security Details',
                style: TextStyle(
                  color: AppTheme.colors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildEmailField(context, passwordEmailProvider),
                    const SizedBox(height: 8.0),
                    _buildPasswordField(context, "New Password"),
                    const SizedBox(height: 8.0),
                    _buildPasswordField(context, "Confirm Password"),
                  ],
                ),
              ),
              actions: [
                _buildActionButton(context, 'Cancel', AppTheme.colors.red, () {
                  Navigator.pop(context);
                }),
                _buildActionButton(context, 'Save', AppTheme.colors.primary, () async {
                  if (!_validateEmail(passwordEmailProvider.userEmail.toString())) {
                    _showSnackbar(context, 'Please enter a valid email address.', AppTheme.colors.red);
                    return;
                  }

                  if (_validatePasswords(passwordEmailProvider)) {
                    await _updateUserDetails(context);
                    Navigator.pushReplacementNamed(context, '/signinscreen');
                  } else {
                    _showSnackbar(context, 'Passwords do not match or are too short.', AppTheme.colors.red);
                  }
                }),

              ],
            );
          },
        );
      },
    );
  }

  Widget _buildEmailField(BuildContext context, PasswordEmailProvider provider) {
    return TextFormField(
      initialValue: userEmailPrev,
      decoration: InputDecoration(
        labelText: "E-mail",
        labelStyle: TextStyle(color: AppTheme.colors.primary),
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
            width: 2,
          ),
        ),
        errorText: provider.emailError,
      ),
      onChanged: (value) {
        provider.email = value;
        // provider.emailError = _validateEmail(value) ? null : 'Invalid email address';
      },
    );
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  Widget _buildPasswordField(BuildContext context, String label) {
    return Consumer<PasswordVisibilityProvider>(
      builder: (context, visibilityProvider, child) {
        return Consumer<PasswordEmailProvider>(
          builder: (context, passwordEmailProvider, child) {
            return TextFormField(
              obscureText: visibilityProvider.visibility,
              onChanged: (value) {
                if (label == "New Password") {
                  passwordEmailProvider.password = value;
                } else {
                  passwordEmailProvider.confirmPassword = value;
                }
              },
              decoration: InputDecoration(
                labelText: label,
                errorText: passwordEmailProvider.errorMessage ?? passwordEmailProvider.lengthError,
                suffixIcon: IconButton(
                  onPressed: () {
                    visibilityProvider.toggleVisibility();
                  },
                  icon: Icon(visibilityProvider.visibility ? Icons.visibility : Icons.visibility_off),
                  color: AppTheme.colors.primary.withOpacity(0.5),
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
                    width: 2,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context, String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 92,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: color, width: 1.5),
          elevation: 0,
          foregroundColor: AppTheme.colors.secondary,
          backgroundColor: color,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.colors.secondary,
          ),
        ),
        child: Text(text),
      ),
    );
  }

  bool _validatePasswords(PasswordEmailProvider provider) {
    return provider.password == provider.confirmPassword && provider.password.length >= 6;
  }

  Future<void> _updateUserDetails(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final provider = Provider.of<PasswordEmailProvider>(context, listen: false);

    try {
      if (user?.email != provider.userEmail) {
        await user?.verifyBeforeUpdateEmail(provider.userEmail!);
      }
      await user?.updatePassword(provider.password);
      _showSnackbar(context, 'Profile updated successfully', AppTheme.colors.ok);
    } catch (e) {
      _showSnackbar(context, 'Failed to update profile. Try again.', AppTheme.colors.red);
    }
  }

  void _showSnackbar(BuildContext context, String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
