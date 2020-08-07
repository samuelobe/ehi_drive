import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Auth auth = Auth();
  Widget initialScreen = await auth.verifyDevice();
  runApp(MyApp(
    screen: initialScreen,
  ));
}

class MyApp extends StatefulWidget {
  final Widget screen;
  MyApp({this.screen});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
        loaderColor: const Color(0xfff67041),
        backgroundColor: Colors.black12,
        seconds: 5,
        photoSize: 100,
        navigateAfterSeconds: widget.screen,
        image: Image.asset('assets/ehidrive-animation.gif'),
      ),
    );
  }
}
