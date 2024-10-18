import 'dart:async';

import 'package:biomark/view/theme/app_theme.dart';
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
    return Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            color: AppTheme.colors.black,
          ),
          child: Image.asset('assets/images/biomark_logo.png',
            alignment: Alignment.center,
          ),
    ));
  }
  void _splashTimer(BuildContext context){
    Timer(const Duration(seconds: 3), (){
      Provider.of<SplashScreenProvider>(context, listen: false).completeSplash();
    });
  }
}
