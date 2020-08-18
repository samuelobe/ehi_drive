import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:ehidrive/theme/theme.dart' as theme;

class StartupScreen extends StatelessWidget {
  final Widget screen;
  const StartupScreen({@required this.screen});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      loaderColor: const Color(0xfff67041),
      backgroundColor: theme.backgroundColor,
      seconds: 5,
      photoSize: 100,
      navigateAfterSeconds: screen,
      image: Image.asset('assets/ehidrive-animation.gif'),
    );
  }
}
