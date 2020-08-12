import 'package:ehidrive/cubit/pin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinButton extends StatelessWidget {
  final double sizedBoxWidth = 50;
  final Color fontColor = Colors.black;
  final double fontSize = 40;
  final String value;

  PinButton({@required this.value});

  @override
  Widget build(BuildContext context) {
    var bloc = context.bloc<PinCubit>();

    return FlatButton(
      child: Text(
        value,
        style: TextStyle(fontSize: fontSize, color: fontColor),
      ),
      onPressed: () => bloc.addNumber(value: value),
    );
  }
}
