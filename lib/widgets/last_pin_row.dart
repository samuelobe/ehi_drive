import 'package:ehidrive/widgets/pin_button.dart';
import 'package:flutter/material.dart';

class LastPinRow extends StatelessWidget {
  const LastPinRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {},
        ),
        PinButton(value: "0"),
        IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {},
        )
      ],
    );
  }
}
