import 'dart:async';

import 'package:ehidrive/widgets/modal_inside_modal.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;
  String _path;
  static const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          _sharedFiles = value;
          _path = (_sharedFiles?.map((f) => f.path)?.join(",") ?? "");
          print(
              "Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
          if (_path != null && _path != "") {
            showBarModalBottomSheet(
              expand: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context, scrollController) => ModalInsideModal(
                  imagePath: _path, scrollController: scrollController),
            );
          }
        });
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          _sharedFiles = value;
          _path = (_sharedFiles?.map((f) => f.path)?.join(",") ?? "");
          print(
              "Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
          if (_path != null && _path != "") {
            showBarModalBottomSheet(
              expand: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context, scrollController) => ModalInsideModal(
                  imagePath: _path, scrollController: scrollController),
            );
          }
        });
      });
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;

        print("Shared: $_sharedText");
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        _sharedText = value;
        print("Shared: $_sharedText");
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Shared files:", style: textStyleBold),
            Text(_path ?? ""),
            SizedBox(height: 100),
            // Text("Shared urls/text:", style: textStyleBold),
            // Text(_sharedText ?? ""),
          ],
        ),
      ),
    );
  }
}
