import 'package:biomark/view/widgets/sign_in_button.dart';
import 'package:biomark/view/widgets/sign_up_button.dart';
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
                          fontWeight: FontWeight.bold
                      ))
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SignInButton(routePath: '/signinscreen', buttonColor: AppTheme.colors.secondary, textColor: AppTheme.colors.primary,)
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SignUpButton(routePath: '/signupscreen',)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
