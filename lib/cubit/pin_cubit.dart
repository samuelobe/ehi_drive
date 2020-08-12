import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class PinCubit extends Cubit<String> {
  PinCubit() : super("");

  void addNumber({@required value}) {
    if (state.length < 4) {
      emit(state + value);
    }
  }
}
