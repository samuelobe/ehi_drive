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
        FlatButton(
          child: Text(
            '0',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {},
        )
      ],
    );
  }
}
