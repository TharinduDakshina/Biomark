import 'package:biomark/view/providers/birthday_provider.dart';
import 'package:biomark/view/providers/password_email_provider.dart';
import 'package:biomark/view/providers/password_visibility_provider.dart';
import 'package:biomark/view/providers/splash_screen_provider.dart';
import 'package:biomark/view/providers/web_view_provider.dart';
import 'package:biomark/view/screens/formScreen.dart';
import 'package:biomark/view/screens/home_screen.dart';
import 'package:biomark/view/screens/main_screen.dart';
import 'package:biomark/view/screens/recovery_screen_1.dart';
import 'package:biomark/view/screens/recovery_screen_2.dart';
import 'package:biomark/view/screens/sign_in_screen.dart';
import 'package:biomark/view/screens/sign_up_screen.dart';
import 'package:biomark/view/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

