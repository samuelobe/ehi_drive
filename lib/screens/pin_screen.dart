import 'package:ehidrive/cubit/pin_cubit.dart';
import 'package:ehidrive/services/auth.dart';
import 'package:ehidrive/widgets/pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    BlocBuilder<PinCubit, String>(
      builder: (context, state) {
        return Container();
      },
    );
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
