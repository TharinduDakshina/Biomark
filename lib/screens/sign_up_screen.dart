import 'package:biomark/providers/birthday_provider.dart';
import 'package:biomark/providers/password_email_provider.dart';
import 'package:biomark/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/password_visibility_provider.dart';
import '../theme/app_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery
    //     .of(context)
    //     .size
    //     .height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(color: AppTheme.colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to Biomark",
                      style: TextStyle(
                          color: AppTheme.colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
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
                              'Full Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: AppTheme.colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: 'Full name',
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
                              'Date of birth',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          Consumer<BirthdayProvider>(
                              builder: (context, birthdayProvider, child) {
                            return TextFormField(
                              readOnly: true,
                              onTap: () {
                                _selectedDate(context, birthdayProvider);
                              },
                              style: TextStyle(
                                  color: AppTheme.colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100),
                              decoration: InputDecoration(
                                suffixIcon:
                                    const Icon(Icons.calendar_month_sharp),
                                hintText: birthdayProvider.getFormattedDate(),
                                hintStyle: TextStyle(
                                  color: AppTheme.colors.black.withOpacity(0.5),
                                  fontSize: 16,
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
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              textAlign: TextAlign.start,
                              "Mother's maiden name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Ex: Julia',
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
                              "Childhood best friend's name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Ex: Peter',
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
                              "Childhood pet's name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Ex: Tommy',
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
                              'City you grew up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Ex: Los Angeles',
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
                              'E-mail address',
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
                              onChanged: (value) {
                                passwordEmailProvider.email = value;
                              },
                              decoration: InputDecoration(
                                  hintText: 'e-mail',
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
                                  errorText: passwordEmailProvider.emailError),
                            );
                          }),
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
                                    hintText: 'Password',
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
                                        icon: Icon(passwordVisibilityProvider
                                                .visibility
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
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
                                              : Icons.visibility_off)),
                                  errorText: passwordEmailProvider.errorMessage,
                                ),
                              );
                            });
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          SignUpButton(
                            routePath: '/',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style:
                                      TextStyle(color: AppTheme.colors.primary),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/signinscreen');
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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

Future<void> _selectedDate(
    BuildContext context, BirthdayProvider provider) async {
  DateTime? birthDay = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now());

  if (birthDay != null) {
    provider.setSelectedDate(birthDay);
  }
}
