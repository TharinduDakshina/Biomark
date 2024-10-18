import 'package:biomark/widgets/sign_in_button.dart';
import 'package:biomark/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(color: AppTheme.colors.primary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Biomark",
                      style: TextStyle(
                          color: AppTheme.colors.secondary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signinscreen');
              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth * 0.8,
                height: 50,
                decoration: BoxDecoration(
                    color: AppTheme.colors.secondary,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: AppTheme.colors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SignUpButton(
                    routePath: '/signupscreen',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
