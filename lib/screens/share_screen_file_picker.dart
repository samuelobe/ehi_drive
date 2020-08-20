import 'dart:io';

import 'package:ehidrive/widgets/share/file_card.dart';
import 'package:ehidrive/widgets/share/thumbnail_card.dart';
import 'package:flutter/material.dart';
import 'package:ehidrive/theme/theme.dart' as theme;

class ShareScreenFilePicker extends StatefulWidget {
  final List<File> filePaths;
  ShareScreenFilePicker({this.filePaths});
  @override
  _ShareScreenFilePickerState createState() => _ShareScreenFilePickerState();
}

class _ShareScreenFilePickerState extends State<ShareScreenFilePicker> {
  List<Widget> _createImageList() {
    var paths = widget.filePaths;
    List<Widget> imageList = [];
    for (var i = 0; i < paths.length; i++) {
      if (paths[i].path != null && paths[i].path != "") {
        if (paths[i].path.contains("jpeg") ||
            paths[i].path.contains("jpg") ||
            paths[i].path.contains("png")) {
          imageList.add(ThumbnailCard(path: paths[i].path));
        } else if (paths[i].path.contains("mp4")) {
          imageList.add(FileCard(path: paths[i].path));
        } else {
          imageList.add(FileCard(path: paths[i].path));
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
    return SafeArea(
          child: GestureDetector(
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
          backgroundColor: theme.backgroundColor,
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
              Flexible(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowGlow();
                        return null;
                      },
                      child: ListView(children: _createImageList()))),
            ],
          ),
        ),
      ),
    );
  }
}
