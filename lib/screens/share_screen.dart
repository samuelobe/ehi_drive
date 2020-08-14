
import 'package:ehidrive/widgets/share/share_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ShareScreen extends StatefulWidget {
  final List<SharedMediaFile> filePaths;
  ShareScreen({this.filePaths});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  List<Widget> _createImageList() {
    var paths = widget.filePaths;
    List<Widget> imageList = [];
    for (var i = 0; i < paths.length; i++) {
      if (paths[i].path != null &&
          paths[i].path != "" &&
          paths[i].type == SharedMediaType.IMAGE) {
        imageList.add(ShareScreenCard(path: paths[i].path));
      }
    }
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Share Screen"),
      ),
      body: ListView(children: _createImageList()),
    );
  }
}
