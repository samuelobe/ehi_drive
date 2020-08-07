import 'dart:io';

import 'package:flutter/material.dart';

class ShareScreen extends StatefulWidget {
  final String imagePath;
  ShareScreen({this.imagePath});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Screen"),
      ),
      body: Center(
        child: widget.imagePath != null && widget.imagePath != ""
            ? Image.file(File(widget.imagePath))
            : Container(
                color: Colors.red,
              ),
      ),
    );
  }
}
