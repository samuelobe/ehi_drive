import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class PinCubit extends Cubit<String> {
  PinCubit() : super("");

  void addNumber({@required value}) {
    if (state.length < 4) {
      emit(state + value);
    }
  }

  void removeNumber() {
    if (state.length > 0) {
      emit(state.substring(0, state.length - 1));
    }
  }

  void clearPin() {
    emit("");
  }
}
