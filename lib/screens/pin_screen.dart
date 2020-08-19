import 'package:ehidrive/cubit/pin_cubit.dart';
import 'package:ehidrive/services/auth.dart';
import 'package:ehidrive/widgets/global/custom_raised_button.dart';
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
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text("Input PIN"),
          ),
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
                      CustomRaisedButton(
                        onPressed: () =>
                            auth.unregisterDevice(context: context),
                        text: "Un-Register",
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
