import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PinScreen extends StatefulWidget {
  PinScreen({Key key}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Pin Screen"),
      ),
    );
  }
}
