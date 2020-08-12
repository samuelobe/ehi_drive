import 'package:ehidrive/cubit/pin_cubit.dart';
import 'package:ehidrive/widgets/pin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastPinRow extends StatelessWidget {
  const LastPinRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCubit, String>(
      builder: (context, state) {
        var bloc = context.bloc<PinCubit>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () => bloc.clearPin(),
            ),
            PinButton(value: "0"),
            IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () => bloc.removeNumber(),
            )
          ],
        );
      },
    );
  }
}
