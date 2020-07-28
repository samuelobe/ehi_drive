
import 'package:ehidrive/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
        loaderColor: const Color(0xfffdfeff),
        backgroundColor: const Color(0xfffdfeff),
        seconds: 5,
        photoSize: 200,
        navigateAfterSeconds: LoginScreen(),
        image: Image.asset('assets/ehidrive-animation.gif'),
      ),
    );
  }
}

