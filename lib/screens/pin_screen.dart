import 'package:ehidrive/cubit/pin_cubit.dart';
import 'package:ehidrive/services/auth.dart';
import 'package:ehidrive/widgets/pin/pin.dart';
import 'package:ehidrive/widgets/pin/pin_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          backgroundColor: Color(0xFFebebeb),
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
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        "Enter PIN",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PinCircles(
                        numActive: state.length,
                      ),
                      // Text(state),
                      SizedBox(height: 50),
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
