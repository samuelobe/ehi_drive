import 'dart:io';

import 'package:ehidrive/cubit/share_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

class ShareScreenCard extends StatefulWidget {
  final String path;
  final String thumbnailPath;
  const ShareScreenCard({@required this.path, this.thumbnailPath});

  @override
  _ShareScreenCardState createState() => _ShareScreenCardState();
}

class _ShareScreenCardState extends State<ShareScreenCard> {
  File croppedFile;

  _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<Null> _cropImage(String path, BuildContext blocContext) async {
    _closeKeyboard();
    var bloc = blocContext.bloc<ShareCubit>();
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
            toolbarColor: const Color(0xfff67041),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings());
    if (croppedFile != null) {
      bloc.changeImage(
          image: Image.file(
        croppedFile,
        width: 75,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var displayPath =
        widget.thumbnailPath == null ? widget.path : widget.thumbnailPath;
    return BlocProvider(
      create: (context) => ShareCubit(
          image: Image.file(
        File(displayPath),
        width: 75,
      )),
      child: BlocBuilder<ShareCubit, Image>(
        builder: (context, imageState) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Card(
              child: ListTile(
                  onTap: widget.thumbnailPath == null
                      ? () => _cropImage(widget.path, context)
                      : () {},
                  title: Text(widget.path),
                  leading: imageState),
            ),
          );
        },
      ),
    );
  }
}
