import 'package:ehidrive/services/auth.dart';
import 'package:ehidrive/widgets/pin.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  Auth auth = Auth();

  void _displayFlushbar(String message) {
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

  void _checkPIN() {
    var pin = _pinPutController.value.text;

    if (pin.length == 0) {
      _displayFlushbar("No values inputted into PIN");
    } else if (pin.length != 4) {
      _displayFlushbar("Please type in your PIN");
    } else {
      auth.verifyPin(pin: pin, context: context);
    }
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: const Color(0xfff67041)),
      borderRadius: BorderRadius.circular(15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFebebeb),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Enter Pin",
                  style: TextStyle(fontSize: 30),
                ),
                // Container(
                //   margin: EdgeInsets.all(20),
                //   padding: EdgeInsets.all(20),
                //   child: PinPut(
                //     textStyle:
                //         TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                //     fieldsCount: 4,
                //     focusNode: _pinPutFocusNode,
                //     controller: _pinPutController,
                //     submittedFieldDecoration: _pinPutDecoration.copyWith(
                //         borderRadius: BorderRadius.circular(20)),
                //     selectedFieldDecoration: _pinPutDecoration,
                //     followingFieldDecoration: _pinPutDecoration.copyWith(
                //       borderRadius: BorderRadius.circular(5),
                //       border: Border.all(
                //         color: const Color(0xfff67041),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 30),
                Pin(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     RaisedButton(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(18.0),
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(14.0),
                //           child: Text(
                //             "Sign In",
                //             style: TextStyle(fontSize: 20),
                //           ),
                //         ),
                //         onPressed: _checkPIN),
                //     RaisedButton(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(18.0),
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(14.0),
                //           child: Text(
                //             "Un-Register",
                //             style: TextStyle(fontSize: 20),
                //           ),
                //         ),
                //         onPressed: () =>
                //             auth.unregisterDevice(context: context)),
                //   ],
                // ),
              ],
            ),
          ),
        ));
  }
}
