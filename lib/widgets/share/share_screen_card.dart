import 'dart:io';

import 'package:ehidrive/cubit/share_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

class ShareScreenCard extends StatefulWidget {
  final String path;
  const ShareScreenCard({@required this.path});

  @override
  _ShareScreenCardState createState() => _ShareScreenCardState();
}

class _ShareScreenCardState extends State<ShareScreenCard> {
  File croppedFile;

  Future<Null> _cropImage(String path, BuildContext blocContext) async {
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
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      bloc.addImage(image: Image.file(croppedFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShareCubit(
          image: Image.file(
        File(widget.path),
      )),
      child: BlocBuilder<ShareCubit, Image>(
        builder: (context, imageState) {
          var path = widget.path;
          return Card(
            child: ListTile(
                onTap: () => _cropImage(widget.path, context),
                title: Text(path),
                leading: imageState),
          );
        },
      ),
    );
  }
}
