import 'package:flutter/material.dart';

class AlertScreen extends StatefulWidget {
  final String message;
  AlertScreen({@required this.message});

  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.message),
      ),
    );
  }
}
