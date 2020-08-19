import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<List<File>> {
  MenuCubit() : super(<File>[]);

  void changeFiles({@required List<File> files}) {
    emit(files);
  }
}
