import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import '../theme/app_theme.dart';
import '../widgets/edit_security_dialog.dart';

class SecurityDetailsScreen extends StatefulWidget {
  const SecurityDetailsScreen({super.key});

  @override
  SecurityDetailsScreenState createState() => SecurityDetailsScreenState();
}

class SecurityDetailsScreenState extends State<SecurityDetailsScreen> {
  String? userEmail;
  String hiddenPassword = "******";

  @override
  void initState() {
    super.initState();
    fetchUserEmail();
  }

  Future<void> fetchUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser; // Get current user
    if (user != null) {
      setState(() {
        userEmail = user.email; // Store email
      });
    } else {
      if (kDebugMode) {
        print('No user is currently signed in.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.colors.secondary,
          shadowColor: AppTheme.colors.secondary,
          title: Text(
            'Security Details',
            style: TextStyle(
              color: AppTheme.colors.primary,
              fontFamily: "Poppins",
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppTheme.colors.primary,
            ),
          ),
        ),
        body: Container(
          width: screenWidth,
          decoration: BoxDecoration(color: AppTheme.colors.secondary),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8.0),
                // Email Field (displaying the fetched email)
                TextFormField(
                  initialValue: userEmail,
                  style: TextStyle(color: AppTheme.colors.blue),
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: AppTheme.colors.primary),
                    hintStyle: TextStyle(
                      color: AppTheme.colors.primary,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: AppTheme.colors.primary,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: AppTheme.colors.red,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: AppTheme.colors.red,
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppTheme.colors.red,
                        width: 2,
                      ),
                    ),
                  ),
                  enabled: false, // Make it read-only
                ),
                const SizedBox(height: 16.0),
                // Password Field
                TextFormField(
                  initialValue: hiddenPassword, // Use initialValue for displaying hidden password
                  style: TextStyle(color: AppTheme.colors.blue),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: AppTheme.colors.primary),
                    hintText: hiddenPassword, // Show hidden password as hint
                    hintStyle: TextStyle(
                      color: AppTheme.colors.primary.withOpacity(0.5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: AppTheme.colors.primary,
                        width: 1.5,
                      ),
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
                        width: 2,
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
                  obscureText: true, // Obscure the actual input
                  enabled: false, // Make it read-only
                ),
                const SizedBox(height: 8,),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => EditSecurityDialog(userEmailPrev: userEmail.toString(),),
                      );
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
                    child: const Text('Edit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
