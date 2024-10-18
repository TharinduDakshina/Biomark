import 'package:biomark/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/password_email_provider.dart';
import '../providers/password_visibility_provider.dart';
import '../theme/app_theme.dart';

class RecoveryScreen2 extends StatelessWidget {
  const RecoveryScreen2({super.key});

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
                      right: screenWidth * 0.1,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text("Create a new password.",
                          style: TextStyle(
                            color: AppTheme.colors.primary
                          ),),
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                textAlign: TextAlign.start,
                                'New password',
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
                                              color: AppTheme.colors.primary.withOpacity(0.5)),
                                          errorText:
                                          passwordEmailProvider.lengthError),
                                    );
                                  });
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                textAlign: TextAlign.start,
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
                                                color: AppTheme.colors.primary.withOpacity(0.5)
                                            )),
                                        errorText: passwordEmailProvider.errorMessage,
                                      ),
                                    );
                                  });
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            SignInButton(routePath: '/homescreen', buttonColor: AppTheme.colors.primary, textColor: AppTheme.colors.secondary)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
