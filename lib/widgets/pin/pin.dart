import 'package:ehidrive/widgets/pin/last_pin_row.dart';
import 'package:flutter/material.dart';

import 'pin_row.dart';

class Pin extends StatelessWidget {
  const Pin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PinRow(firstValue: "1", secondValue: "2", thirdValue: "3"),
          PinRow(firstValue: "4", secondValue: "5", thirdValue: "6"),
          PinRow(firstValue: "7", secondValue: "8", thirdValue: "9"),
          LastPinRow()
        ],
      ),
    );
  }
}
