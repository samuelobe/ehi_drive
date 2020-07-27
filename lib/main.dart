import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
        navigateAfterSeconds: MyHomePage(title: "Home Page",),
        image: Image.asset('assets/ehidrive-animation.gif'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final String requestBody = """ 
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <VerifyDevice_1_2_2 xmlns="http://emr.ehiconnect.com/">
      <sApikey>B73C9433-A251-40A5-B60C-A8EA5D35E79F</sApikey>
      <sDeviceId>123456</sDeviceId>
      <sAppVersion>"1.0.0"</sAppVersion>
      <sRegisterId>123456</sRegisterId>
    </VerifyDevice_1_2_2>
  </soap12:Body>
</soap12:Envelope>""";

  _sendMessageLogin() async {
    http.Response response = await http
        .post('https://ehix.ehiconnect.com/ws2/pin.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "Host": "ehix.ehiconnect.com",
              "SOAPAction": "http://emr.ehiconnect.com/VerifyDevice_1_2_2"
            },
            body: utf8.encode(requestBody),
            )
        .then((onValue) {
      print("Response status: ${onValue.statusCode}");
      print("Response body: ${onValue.body}");
    });

    print(response);
  }

  _sendMessagePin() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessageLogin,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
