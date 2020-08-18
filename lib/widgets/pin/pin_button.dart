import 'package:ehidrive/cubit/pin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinButton extends StatelessWidget {
  final double sizedBoxWidth = 50;
  final Color fontColor = Colors.black;
  final double fontSize = 35;
  final String value;

  PinButton({@required this.value});

  @override
  Widget build(BuildContext context) {
    var bloc = context.bloc<PinCubit>();

    return InkWell(
      customBorder: CircleBorder(),
      enableFeedback: true,
      onTap: () => bloc.addNumber(value: value),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize, color: fontColor),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.height * 0.15,
          )
        ],
      ),
    );
  }
}
