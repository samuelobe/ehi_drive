import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ShareCubit extends Cubit<Image> {
  final Image image;
  ShareCubit({@required this.image}) : super(image);

  void changeImage({@required Image image}) {
    emit(image);
  }
}
