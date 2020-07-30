import 'soap.dart';
import 'package:ehidrive/models/user.dart';
import 'package:ehidrive/screens/alert_screen.dart';
import 'package:ehidrive/screens/auth_screen.dart';
import 'package:ehidrive/screens/create_pin_screen.dart';
import 'package:ehidrive/screens/login_screen.dart';
import 'package:ehidrive/screens/menu_screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

class Auth {
  final SOAP soap = SOAP();

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

  void _showFlushbar(BuildContext context, String message) {
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

    try {
      http.Response response = await soap.postVerifyDevice();

      var statusCode = response.statusCode;

      if (statusCode == 200) {
        var document = XmlDocument.parse(response.body);

        print(document.toXmlString(pretty: true, indent: '\t'));

        success = _getElement(document, 'success') == 'true';
        errorcode = _getElement(document, 'errorcode');
        message = _getElement(document, 'message');

        print("Success: $success, Errorcode: $errorcode, Message: $message");

        if (success) {
          print("Going to Pin Screen");
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

  registerDevice(
      {@required String pin,
      @required String userID,
      @required BuildContext context}) async {
    bool success;
    final prefs = await SharedPreferences.getInstance();

    try {
      http.Response response =
          await soap.postRegisterDevice(pin: pin, userID: userID);

      if (response.statusCode == 200) {
        var document = XmlDocument.parse(response.body);
        print(document.toXmlString(pretty: true, indent: '\t'));
        success = _getElement(document, 'success') == 'true';
        if (success) {
          prefs.setString("pin", pin);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuScreen(),
              ));
        } else {
          _showFlushbar(context, "Registration Failed");
        }
        print('New Device Registration Succeeded? $success');
      } else {
        _showFlushbar(context, "Network Error");
      }
    } catch (e) {
      _showFlushbar(context, e.toString());
      print(e);
    }
  }

  verifyUser({User user, BuildContext context}) async {
    bool success;
    String errorcode;
    String message;

    final prefs = await SharedPreferences.getInstance();
    //TODO: ADD SYSTEM DATA HERE

    try {
      http.Response response = await soap.postVerifyUser(user: user);
      var statusCode = response.statusCode;

      if (statusCode == 200) {
        var document = XmlDocument.parse(response.body);

        print(document.toXmlString(pretty: true, indent: '\t'));

        success = _getElement(document, 'success') == 'true';
        errorcode = _getElement(document, 'errorcode');
        message = _getElement(document, 'message');

        print("Success: $success, Errorcode: $errorcode, Message: $message");

        if (success) {
          var pinCreated = prefs.getString('pin') == null;
          if (!pinCreated) {
            print('Going to Menu Screen');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MenuScreen()));
          } else {
            print("Going to Pin Screen");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePinScreen(
                    user: user,
                  ),
                ));
          }
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

  verifyPin({@required String pin, @required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();

    var storedPin = prefs.getString('pin');

    if (pin == storedPin) {
      print('Pin Accepted!');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MenuScreen()));
    } else {
      _showFlushbar(context, "Incorrect PIN");
    }
  }

//   verifyPin({String pin, BuildContext context}) async {
//     bool success;
//     String errorcode;
//     String message;
//     String deviceID = await _getId();

//     var requestBody = """
// <?xml version="1.0" encoding="utf-8"?>
// <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
//   <soap:Body>
//     <VerifyPin xmlns="http://emr.ehiconnect.com/">
//       <sApikey>$apiKey</sApikey>
//       <sDeviceId>$deviceID</sDeviceId>
//       <sPin>$pin</sPin>
//     </VerifyPin>
//   </soap:Body>
// </soap:Envelope>""";

//     try {
//       http.Response response = await http.post(
//         apiURL,
//         headers: {
//           "Content-Type": "text/xml; charset=utf-8",
//           "Host": "ehix.ehiconnect.com",
//           "SOAPAction": "http://emr.ehiconnect.com/VerifyPin"
//         },
//         body: utf8.encode(requestBody),
//       );
//       var statusCode = response.statusCode;

//       if (statusCode == 200) {
//         var document = XmlDocument.parse(response.body);

//         print(document.toXmlString(pretty: true, indent: '\t'));
//         print(deviceID);

//         success = _getElement(document, 'success') == 'true';
//         errorcode = _getElement(document, 'errorcode');
//         message = _getElement(document, 'message');

//         print("Success: $success, Errorcode: $errorcode, Message: $message");

//         if (success) {
//           print("Going to Pin Screen");
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => MenuScreen()));
//         } else {
//           _showFlushbar(context, message);
//         }
//       } else {
//         message = 'Network Error: $statusCode';
//         _showFlushbar(context, message);
//       }
//     } catch (e) {
//       print(e);
//       _showFlushbar(context, e.toString());
//     }
//   }
}
