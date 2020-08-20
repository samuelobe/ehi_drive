// import 'dart:async';
import 'dart:io';

import 'package:ehidrive/cubit/menu_cubit.dart';
// import 'package:ehidrive/screens/share_screen.dart';
import 'package:ehidrive/screens/share_screen_file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // StreamSubscription _intentDataStreamSubscription;
  // List<SharedMediaFile> _sharedFiles;
  // String _sharedText;
  bool _isLoading = false;

  getFiles(BuildContext blocContext) async {
    var files = await FilePicker.getMultiFile(type: FileType.any
        // type: FileType.custom,
        // allowedExtensions: [
        //   'jpg',
        //   'pdf',
        //   'jpeg',
        //   'png',
        //   'zip',
        //   'rar',
        //   'mp4',
        //   'txt'
        // ],
        );
    var bloc = blocContext.bloc<MenuCubit>();
    bloc.changeFiles(files: files);
    if (files != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ShareScreenFilePicker(
          filePaths: files,
        );
      }));
    }
  }

  // @override
  // void initState() {
  //   super.initState();

  //   // For sharing images coming from outside the app while the app is in the memory
  //   _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
  //       .listen((List<SharedMediaFile> value) {
  //     print(value);

  //     print('MEMORY');
  //     setState(() {
  //       _sharedFiles = value;
  //       // _path = (_sharedFiles?.map((f) => f.path)?.join(",") ?? "");
  //       if (_sharedFiles != null) {
  //         // print(_sharedFiles);
  //         Navigator.push(context, MaterialPageRoute(builder: (context) {
  //           return ShareScreen(
  //             filePaths: _sharedFiles ?? [],
  //           );
  //         }));
  //       }
  //     });
  //   }, onError: (err) {
  //     print("getIntentDataStream error: $err");
  //   });

  //   // For sharing images coming from outside the app while the app is closed
  //   ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
  //     print(value);
  //     // Future.delayed(const Duration(milliseconds: 500), () {
  //     print('CLOSED');
  //     setState(() {
  //       _sharedFiles = value;
  //       // _path = (_sharedFiles?.map((f) => f.path)?.join(",") ?? "");
  //       if (_sharedFiles != null) {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ShareScreen(
  //                 filePaths: _sharedFiles ?? [],
  //               ),
  //             ));
  //       }
  //       // });
  //     });
  //   });

  //   // For sharing or opening urls/text coming from outside the app while the app is in the memory
  //   _intentDataStreamSubscription =
  //       ReceiveSharingIntent.getTextStream().listen((String value) {
  //     setState(() {
  //       _sharedText = value;

  //       print("Shared: $_sharedText");
  //     });
  //   }, onError: (err) {
  //     print("getLinkStream error: $err");
  //   });

  //   // For sharing or opening urls/text coming from outside the app while the app is closed
  //   ReceiveSharingIntent.getInitialText().then((String value) {
  //     setState(() {
  //       _sharedText = value;
  //       print("Shared: $_sharedText");
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   _intentDataStreamSubscription.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => MenuCubit(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text('Menu Screen'),
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<MenuCubit, List<File>>(
            builder: (context, files) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isLoading == false
                        ? FlatButton(
                            child: Text("Upload files to EHI Drive"),
                            color: Colors.grey,
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await getFiles(context);
                              setState(() {
                                _isLoading = false;
                              });
                            },
                          )
                        : CircularProgressIndicator()
                    // Text(files != null ? files.length.toString() : "0"),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
