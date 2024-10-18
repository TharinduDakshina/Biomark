import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String routePath;
  final Color textColor, buttonColor;
  const SignInButton({super.key, required this.routePath, required this.buttonColor, required this.textColor});



  @override
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
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
