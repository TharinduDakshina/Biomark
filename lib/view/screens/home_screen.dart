import 'package:biomark/view//theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../auth/auth_service.dart';
import '../providers/web_view_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final webViewProvider = Provider.of<WebViewProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebViewWidget(controller: webViewProvider.controller),
            Positioned(
              left: 16, // Distance from the left
              bottom: 16, // Distance from the bottom
              child: SpeedDial(
                overlayColor: AppTheme.colors.black,
                icon: Icons.question_mark_rounded,
                activeIcon: Icons.close,
                backgroundColor: AppTheme.colors.secondary,
                children: [
                  SpeedDialChild(
                    child: Icon(
                      Icons.logout_rounded,
                      color: AppTheme.colors.red,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: AppTheme.colors.primary,
                            iconColor: AppTheme.colors.white,
                            elevation: 0,
                            title: Text(
                              'Sign Out?',
                              style: TextStyle(
                                color: AppTheme.colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            shadowColor: AppTheme.colors.black,
                            surfaceTintColor: AppTheme.colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            actions: [
                              SizedBox(
                                width: 92,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppTheme.colors.primary,
                                        width: 1.5),
                                    elevation: 0,
                                    foregroundColor: AppTheme.colors.primary,
                                    backgroundColor: AppTheme.colors.secondary,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text('No'),
                                ),
                              ),
                              SizedBox(
                                width: 92,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await AuthService().signOut();
                                    Navigator.pushReplacementNamed(
                                        context, '/signinscreen');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppTheme.colors.white,
                                        width: 1.5),
                                    elevation: 0,
                                    foregroundColor: AppTheme.colors.secondary,
                                    backgroundColor: AppTheme.colors.secondary,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.colors.red
                                    ),
                                  ),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: AppTheme.colors.red, // Set the "Yes" text color to white
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: Icon(
                      Icons.handshake_outlined,
                      color: AppTheme.colors.primary,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/formscreen');
                    },
                  ),
                  SpeedDialChild(
                    child: Icon(
                      Icons.lock,
                      color: AppTheme.colors.primary,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/securityscreen');
                    },
                  ),
                  SpeedDialChild(
                    child: Icon(
                      Icons.person,
                      color: AppTheme.colors.primary,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/personalscreen');
                    },
                  ),
                ],
                activeChild: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/close.svg',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child:
                      SvgPicture.asset('assets/icons/b.svg', fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
