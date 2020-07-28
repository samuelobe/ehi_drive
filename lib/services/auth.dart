import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:ehidrive/models/user.dart';
import 'package:ehidrive/screens/alert_screen.dart';
import 'package:ehidrive/screens/auth_screen.dart';
import 'package:ehidrive/screens/create_pin_screen.dart';
import 'package:ehidrive/screens/login_screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

class Auth {
  final String apiKey = "B73C9433-A251-40A5-B60C-A8EA5D35E79F";
  final String apiURL = "https://ehix.ehiconnect.com/ws2/pin.asmx";
  final String deviceType = Platform.isIOS ? "iOS" : "Android";

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  String _getElement(XmlDocument document, String elementName) {
    var element;
    try {
      element = document.findAllElements(elementName).length != 0
          ? document
              .findAllElements(elementName)
              .first
              .children
              .first
              .toString()
          : null;
    } catch (e) {
      element = null;
    }

    return element;
  }

  _showFlushbar(BuildContext context, String message) {
    Flushbar(
      margin: EdgeInsets.only(bottom: 5),
      maxWidth: MediaQuery.of(context).size.width * 0.95,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: 8,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      isDismissible: true,
      duration: Duration(seconds: 3),
      //animationDuration: Duration(milliseconds: 100),
    )..show(context);
  }

  Future<Widget> verifyDevice() async {
    bool success;
    String errorcode;
    String message;
    String deviceID = await _getId();

    final prefs = await SharedPreferences.getInstance();

    var requestBody = """ 
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <VerifyDevice_1_2_2 xmlns="http://emr.ehiconnect.com/">
      <sApikey>$apiKey</sApikey>
      <sDeviceId>$deviceID</sDeviceId>
      <sAppVersion>"1.0.0"</sAppVersion>
      <sRegisterId>123456</sRegisterId> 
    </VerifyDevice_1_2_2>
  </soap12:Body>
</soap12:Envelope>""";

    try {
      http.Response response = await http.post(
        apiURL,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "Host": "ehix.ehiconnect.com",
          "SOAPAction": "http://emr.ehiconnect.com/VerifyDevice_1_2_2"
        },
        body: utf8.encode(requestBody),
      );
      var statusCode = response.statusCode;
      var valueIsEmpty = prefs.getBool('deviceVerified') == null;

      if (valueIsEmpty) {
        prefs.setBool('deviceVerified', false);
      }

      if (statusCode == 200) {
        var document = XmlDocument.parse(response.body);

        print(document.toXmlString(pretty: true, indent: '\t'));
        print(deviceID);
        success = _getElement(document, 'success') == 'true';
        errorcode = _getElement(document, 'errorcode');
        message = _getElement(document, 'message');

        print("Success: $success, Errorcode: $errorcode, Message: $message");

        if (success) {
          print("Going to Pin Screen");
          prefs.setBool('deviceVerified', true);
          return AuthScreen();
        } else if (!success && errorcode == 'VD002') {
          print("Going to Login Screen");
          return LoginScreen();
        } else {
          print("Going to Alert Screen");
          return AlertScreen(
            message: message,
          );
        }
      } else {
        print("Going to Alert Screen");
        return AlertScreen(
          message: "Error $statusCode",
        );
      }
    } catch (e) {
      print(e);
      print("Going to Alert Screen");
      return AlertScreen(
        message: e.toString(),
      );
    }
  }

  registerDevice(String pin, String userID) async {
    var success;
    var deviceID = await _getId();
    var requestBody = """ 
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <RegisterDevice xmlns="http://emr.ehiconnect.com/">
      <sApikey>$apiKey</sApikey>
      <sUserId>$userID</sUserId>
      <sDeviceId>$deviceID</sDeviceId>
      <sRegisterId>123456</sRegisterId>
      <sPin>$pin</sPin>
    </RegisterDevice>
  </soap:Body>
</soap:Envelope>""";

    try {
      http.Response response = await http.post(
        apiURL,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "Host": "ehix.ehiconnect.com",
          "SOAPAction": "http://emr.ehiconnect.com/RegisterDevice"
        },
        body: utf8.encode(requestBody),
      );

      if (response.statusCode == 200) {
        var document = XmlDocument.parse(response.body);
        print(document.toXmlString(pretty: true, indent: '\t'));
        success = document.findAllElements('success').first.children.first;
        print('New Device Registration Succeeded?: $success');
      }
    } catch (e) {
      print(e);
    }
  }

  verifyUser({User user, BuildContext context}) async {
    bool success;
    String errorcode;
    String message;
    String username = user.username;
    String password = user.password;
    String deviceID = await _getId();

    String systemData = "$deviceID-$deviceType-1.0.0";
    //TODO: ADD SYSTEM DATA HERE
    var requestBody = """ 
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <VerifyUser xmlns="http://emr.ehiconnect.com/">
      <sApikey>$apiKey</sApikey>
      <sUserId>$username</sUserId>
      <sPassword>$password</sPassword>
      <sDeviceId>$deviceID</sDeviceId>
      <sSysData>$systemData</sSysData>
    </VerifyUser>
  </soap:Body>
</soap:Envelope>""";

    try {
      http.Response response = await http.post(
        apiURL,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "Host": "ehix.ehiconnect.com",
          "SOAPAction": "http://emr.ehiconnect.com/VerifyUser"
        },
        body: utf8.encode(requestBody),
      );
      var statusCode = response.statusCode;

      if (statusCode == 200) {
        var document = XmlDocument.parse(response.body);

        print(document.toXmlString(pretty: true, indent: '\t'));
        print(deviceID);

        success = _getElement(document, 'success') == 'true';
        errorcode = _getElement(document, 'errorcode');
        message = _getElement(document, 'message');

        print("Success: $success, Errorcode: $errorcode, Message: $message");

        if (success) {
          print("Going to Pin Screen");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePinScreen(
                  user: user,
                ),
              ));
        } else {
          _showFlushbar(context, message);
        }
      } else {
        message = 'Network Error: $statusCode';
        _showFlushbar(context, message);
      }
    } catch (e) {
      print(e);
      _showFlushbar(context, e.toString());
    }
  }
}
