import 'package:flutter/material.dart';

class FileCard extends StatelessWidget {
  final String path;
  FileCard({this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Card(
        child: ListTile(title: Text(path), leading: Icon(Icons.description, size: 30,)),
      ),
    );
  }
}
