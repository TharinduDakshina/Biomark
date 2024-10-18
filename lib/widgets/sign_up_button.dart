import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SignUpButton extends StatelessWidget {
  final String routePath;
  const SignUpButton({super.key, required this.routePath});

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, routePath);
      },
      child: Container(
        alignment: Alignment.center,
        width: screenWidth * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.colors.primary,
          border: Border.all(
              color: AppTheme.colors.secondary,
              width: 1
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Sign Up",
          style: TextStyle(
              color: AppTheme.colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
    );
  }
}
