import 'package:ehidrive/cubit/pin_cubit.dart';
import 'package:ehidrive/services/auth.dart';
import 'package:ehidrive/widgets/pin/pin.dart';
import 'package:ehidrive/widgets/pin/pin_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehidrive/theme/theme.dart' as theme;

class PinScreen extends StatefulWidget {
  @override
  PinScreenState createState() => PinScreenState();
}

class PinScreenState extends State<PinScreen> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PinCubit(),
      child: Scaffold(
          backgroundColor: theme.backgroundColor,
          body: BlocBuilder<PinCubit, String>(
            builder: (context, state) {
              if (state.length == 4) {
                auth.verifyPin(pin: state, context: context);
              }
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      PinCircles(
                        numActive: state.length,
                      ),
                      SizedBox(height: 40),
                      Pin(),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  "Un-Register",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              onPressed: () =>
                                  auth.unregisterDevice(context: context)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
