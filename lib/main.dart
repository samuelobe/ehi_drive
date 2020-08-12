import 'package:ehidrive/screens/startup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Auth auth = Auth();
  Widget initialScreen = await auth.verifyDevice();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
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
        home: StartupScreen(
          screen: widget.screen,
        ));
  }
}
