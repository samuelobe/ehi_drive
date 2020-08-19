import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  CustomRaisedButton({@required this.text, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: RaisedButton(
        elevation: 0,
        color: Colors.white,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
            
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
