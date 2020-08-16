import 'package:ehidrive/widgets/share/share_screen_card.dart';
import 'package:flutter/cupertino.dart';
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
      if (paths[i].path != null && paths[i].path != "") {
        if (paths[i].type == SharedMediaType.IMAGE) {
          imageList.add(ShareScreenCard(path: paths[i].path));
        } else if (paths[i].type == SharedMediaType.VIDEO) {
          imageList.add(ShareScreenCard(
            path: paths[i].path,
            thumbnailPath: paths[i].thumbnail,
          ));
        }
      }
    }
    return imageList;
  }

  _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeKeyboard,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            ),
          ],
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
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
                  keyboardType: TextInputType.text,
                  minLines: 5,
                  maxLines: 10,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Write your upload description here',
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
            Flexible(child: ListView(children: _createImageList())),
          ],
        ),
      ),
    );
  }
}
