import 'package:ehidrive/models/user.dart';
import 'package:ehidrive/services/auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class CreatePinScreen extends StatefulWidget {
  final User user;
  CreatePinScreen({this.user});
  @override
  CreatePinScreenState createState() => CreatePinScreenState();
}

class CreatePinScreenState extends State<CreatePinScreen> {
  final TextEditingController _pinPutController1 = TextEditingController();
  final FocusNode _pinPutFocusNode1 = FocusNode();
  final TextEditingController _pinPutController2 = TextEditingController();
  final FocusNode _pinPutFocusNode2 = FocusNode();
  final Auth auth = Auth();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(15),
    );
  }

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

  void createPin() async {
    String firstPin = _pinPutController1.value.text;
    String secondPin = _pinPutController2.value.text;
    var text;
    if (firstPin.length < 4 || secondPin.length < 4) {
      text = "Please fill out both pin fields";
      _displayFlushbar(text);
    } else if (firstPin == secondPin) {
      auth.registerDevice(
          pin: firstPin, userID: widget.user.username, context: context);
    } else {
      text = "Inputted PINs are not the same";
      _displayFlushbar(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create PIN"),
      ),
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Create your pin"),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    child: PinPut(
                      fieldsCount: 4,
                      focusNode: _pinPutFocusNode1,
                      controller: _pinPutController1,
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20)),
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("Verify your pin"),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    child: PinPut(
                      fieldsCount: 4,
                      focusNode: _pinPutFocusNode2,
                      controller: _pinPutController2,
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20)),
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        "Create PIN",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: createPin,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
