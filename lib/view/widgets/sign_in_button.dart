import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  // final String routePath;
  final VoidCallback onPressed;
  final Color textColor, buttonColor;
  const SignInButton({super.key, required this.onPressed, required this.buttonColor, required this.textColor});



  @override
  Widget build(BuildContext context){
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        width: screenWidth * 0.8,
        height: 50,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Text(
          "Sign In",
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
    );
  }
}
