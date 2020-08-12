import 'package:bloc/bloc.dart';

class PinCubit extends Cubit<String> {
  int pinLength = 0;
  PinCubit() : super("");

  void addNumber(value) {
    if (pinLength <= 4) {
      emit(state + value);
    }
    pinLength++;
  }
}
