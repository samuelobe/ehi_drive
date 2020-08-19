import 'package:flutter/material.dart';

class PinCircles extends StatelessWidget {
  final int numActive;
  PinCircles({@required this.numActive});

  List<Widget> _createRow() {
    List<Widget> rowList = [];

    for (var i = 0; i < 4; i++) {
      rowList.add(_Circle(active: i < numActive));
      if (i < 4 - 1) {
        rowList.add(SizedBox(
          width: 10,
        ));
      }
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: _createRow());
  }
}

class _Circle extends StatelessWidget {
  final bool active;

  _Circle({this.active});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xfff67041) : Colors.grey,
      ),
    );
  }
}
