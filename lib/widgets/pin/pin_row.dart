import 'package:ehidrive/widgets/pin/pin_button.dart';
import 'package:flutter/material.dart';

class PinRow extends StatelessWidget {
  final String firstValue;
  final String secondValue;
  final String thirdValue;

  PinRow({this.firstValue, this.secondValue, this.thirdValue});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PinButton(
          value: firstValue,
        ),
        PinButton(value: secondValue),
        PinButton(
          value: thirdValue,
        ),
      ],
    );
  }
}
