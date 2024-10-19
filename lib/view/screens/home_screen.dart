import 'package:biomark/view//theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
                      // Add your favorite functionality here
                    },
                  ),
                  SpeedDialChild(
                    child: Icon(
                      Icons.person,
                      color: AppTheme.colors.primary,
                    ),
                    onTap: () {
                      // Add your settings functionality here
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
