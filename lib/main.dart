import 'package:biomark/providers/birthday_provider.dart';
import 'package:biomark/providers/password_email_provider.dart';
import 'package:biomark/providers/password_visibility_provider.dart';
import 'package:biomark/providers/splash_screen_provider.dart';
import 'package:biomark/providers/web_view_provider.dart';
import 'package:biomark/screens/formScreen.dart';
import 'package:biomark/screens/home_screen.dart';
import 'package:biomark/screens/main_screen.dart';
import 'package:biomark/screens/recovery_screen_1.dart';
import 'package:biomark/screens/recovery_screen_2.dart';
import 'package:biomark/screens/sign_in_screen.dart';
import 'package:biomark/screens/sign_up_screen.dart';
import 'package:biomark/screens/splash_screen.dart';
// import 'package:biomark/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
      ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
      ChangeNotifierProvider(create: (_) => BirthdayProvider()),
      ChangeNotifierProvider(create: (_) => PasswordEmailProvider()),
      ChangeNotifierProvider(create: (_) => WebViewProvider())
    ],

    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biomark',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Consumer<SplashScreenProvider>(
        builder: (context, splashProvider, child) {
          return splashProvider.isSplashCompleted
              ? const MainScreen()
              : const SplashScreen();
        },
      ),
      initialRoute: '/',
      routes: {
        '/mainscreen': (context) => const MainScreen(),
        '/signinscreen': (context) => const SignInScreen(),
        '/signupscreen': (context) => const SignUpScreen(),
        '/recoveryscreen1': (context) => const RecoveryScreen1(),
        '/recoveryscreen2': (context) => const RecoveryScreen2(),
        '/homescreen': (context) => const HomeScreen(),
        '/formscreen': (context) => const FormScreen(),
      },

    );
  }
}
