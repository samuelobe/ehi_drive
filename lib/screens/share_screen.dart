import 'dart:io';

import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:image_cropper/image_cropper.dart';

class ShareScreen extends StatefulWidget {
  final List<SharedMediaFile> filePaths;
  ShareScreen({this.filePaths});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  File croppedFile;
  Future<Null> _cropImage(String path) async {
    croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
  }

  List<Widget> _createImageList() {
    var paths = widget.filePaths;
    List<Widget> imageList = [];
    for (var i = 0; i < paths.length; i++) {
      if (paths[i].path != null &&
          paths[i].path != "" &&
          paths[i].type == SharedMediaType.IMAGE) {
        imageList.add(Card(
          child: ListTile(
              onTap: () => _cropImage(paths[i].path),
              leading: Image.file(
                File(paths[i].path),
              )),
        ));
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
