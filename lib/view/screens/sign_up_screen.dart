import 'package:biomark/view/providers/birthday_provider.dart';
import 'package:biomark/view/providers/password_email_provider.dart';
import 'package:biomark/view/widgets/sign_up_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/password_visibility_provider.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

late DateTime dateOfBirth;

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String fullName = '';
  String mothersMaidenName = '';
  String bestFriendName = '';
  String petName = '';
  String cityGrewUp = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> registerUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || fullName.isEmpty || mothersMaidenName.isEmpty || bestFriendName.isEmpty || petName.isEmpty || cityGrewUp.isEmpty || dateOfBirth == null) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('All fields are required.'),
            backgroundColor: AppTheme.colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match.'),
            backgroundColor: AppTheme.colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }

      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'dateOfBirth': dateOfBirth,
          'mothersMaidenName': mothersMaidenName,
          'bestFriendName': bestFriendName,
          'petName': petName,
          'cityGrewUp': cityGrewUp,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: AppTheme.colors.ok,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );

        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), // Adjust accordingly
        );
      } catch (e) {
        // Print error to console for debugging
        print('Registration error: $e');

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign Up failed. Please try again.'),
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
                          color: AppTheme.colors.primary,
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
                      child: Form(
                        key: _formKey,
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
                              onChanged: (value) => fullName = value,
                              style: TextStyle(
                                  color: AppTheme.colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'Full name',
                                hintStyle: TextStyle(
                                  color:
                                      AppTheme.colors.primary.withOpacity(0.5),
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
                                    color: AppTheme.colors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Consumer<BirthdayProvider>(
                              builder: (context, birthdayProvider, child) {
                                return TextFormField(
                                  readOnly: true, // Keep it read-only since you use a date picker
                                  onTap: () {
                                    // dateOfBirth = birthdayProvider.getFormattedDate() as DateTime;
                                    _selectedDate(context, birthdayProvider); // Trigger date picker
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.calendar_month_sharp,
                                      color: AppTheme.colors.primary.withOpacity(0.5),
                                    ),
                                    hintText: birthdayProvider.getFormattedDate(), // Get formatted date from provider
                                    hintStyle: TextStyle(
                                      color: AppTheme.colors.primary.withOpacity(0.5),
                                      fontSize: 16,
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
                                  ),
                                );
                              },
                            ),

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
                              onChanged: (value) => mothersMaidenName = value,
                              style: TextStyle(
                                  color: AppTheme.colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'Ex: Julia',
                                hintStyle: TextStyle(
                                  color:
                                      AppTheme.colors.primary.withOpacity(0.5),
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
                              onChanged: (value) => bestFriendName = value,
                              style: TextStyle(
                                  color: AppTheme.colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'Ex: Peter',
                                hintStyle: TextStyle(
                                  color:
                                      AppTheme.colors.primary.withOpacity(0.5),
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
                              onChanged: (value) => petName = value,
                              style: TextStyle(
                                  color: AppTheme.colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'Ex: Tommy',
                                hintStyle: TextStyle(
                                  color:
                                      AppTheme.colors.primary.withOpacity(0.5),
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
                              onChanged: (value) => cityGrewUp = value,
                              style: TextStyle(
                                  color: AppTheme.colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'Ex: Los Angeles',
                                hintStyle: TextStyle(
                                  color:
                                      AppTheme.colors.primary.withOpacity(0.5),
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
                            Consumer<PasswordEmailProvider>(builder:
                                (context, passwordEmailProvider, child) {
                              return TextFormField(
                                controller: _emailController,
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
                                    errorText:
                                        passwordEmailProvider.emailError),
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
                            Consumer<PasswordEmailProvider>(builder:
                                (context, passwordEmailProvider, child) {
                              return Consumer<PasswordVisibilityProvider>(
                                  builder: (context, passwordVisibilityProvider,
                                      child) {
                                return TextFormField(
                                  controller: _passwordController,
                                  obscureText:
                                      passwordVisibilityProvider.visibility,
                                  onChanged: (value) {
                                    passwordEmailProvider.password = value;
                                  },
                                  style: TextStyle(
                                      color: AppTheme.colors.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: AppTheme.colors.primary
                                            .withOpacity(0.5),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                          color: AppTheme.colors.primary,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                          color: AppTheme.colors.primary,
                                          width: 1,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                            .withOpacity(0.5),
                                      ),
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
                            Consumer<PasswordEmailProvider>(builder:
                                (context, passwordEmailProvider, child) {
                              return Consumer<PasswordVisibilityProvider>(
                                  builder: (context, passwordVisibilityProvider,
                                      child) {
                                return TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText:
                                      passwordVisibilityProvider.visibility,
                                  onChanged: (value) {
                                    passwordEmailProvider.confirmPassword =
                                        value;
                                  },
                                  style: TextStyle(
                                      color: AppTheme.colors.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    hintText: 'Confirm password',
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
                                        passwordEmailProvider.errorMessage,
                                  ),
                                );
                              });
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignUpButton(
                      onPressed: registerUser,
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
                            style: TextStyle(color: AppTheme.colors.primary),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signinscreen');
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.colors.primary),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
}

Future<void> _selectedDate(
    BuildContext context, BirthdayProvider provider) async {
  DateTime? birthDay = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (birthDay != null) {
    provider.setSelectedDate(birthDay);
    dateOfBirth = birthDay;
    // Set the selected date in provider
  }
}
