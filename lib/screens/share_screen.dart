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
      backgroundColor: Color(0xFFebebeb),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                minLines: 5,
                maxLines: 10,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Write your status here',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            thickness: 4,
            color: const Color(0xfff67041),
          ),
          Flexible(child: ListView(children: _createImageList())),
        ],
      ),
    );
  }
}
