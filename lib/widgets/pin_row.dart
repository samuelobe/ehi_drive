import 'package:flutter/material.dart';

class PinRow extends StatelessWidget {
  final String firstValue;
  final String secondValue;
  final String thirdValue;
  final double sizedBoxWidth = 50;
  final Color fontColor = Colors.black;
  final double fontSize = 40;

  PinRow({this.firstValue, this.secondValue, this.thirdValue});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
      children: [
        FlatButton(
          child: Text(
            firstValue,
            style: TextStyle(fontSize: fontSize, color: fontColor),
          ),
          onPressed: () {},
        ),

        FlatButton(
          child: Text(secondValue, style: TextStyle(fontSize: fontSize, color: fontColor)),
          onPressed: () {},
        ),

        FlatButton(
          child: Text(thirdValue, style: TextStyle(fontSize: fontSize, color: fontColor)),
          onPressed: () {},
        ),
      ],
    );
  }
}
