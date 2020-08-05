import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalInsideModal extends StatelessWidget {
  final ScrollController scrollController;
  final String imagePath;
  final bool reverse;

  const ModalInsideModal(
      {Key key, this.scrollController, this.reverse = false, this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: imagePath != null && imagePath != ""
            ? Image.file(File(imagePath))
            : Container(color: Colors.red,),
      ),
    );
  }
}
