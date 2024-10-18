import 'dart:async';
import 'package:biomark/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/splash_screen_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    _splashTimer(context);
    return SafeArea(
      child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              color: AppTheme.colors.secondary,
            ),
            child: Center(
              child: SizedBox(
                height: 80,
                child: Image.asset(
                  'assets/images/biomark_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          )),
    );
  }

  void _splashTimer(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Provider.of<SplashScreenProvider>(context, listen: false)
          .completeSplash();
    });
  }
}
