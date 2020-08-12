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
    return BlocProvider(
      create: (context) => PinCubit(),
      child: Scaffold(
          backgroundColor: Color(0xFFebebeb),
          body: BlocBuilder<PinCubit, String>(
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Enter Pin",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(state),
                      SizedBox(height: 30),
                      Pin(),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
