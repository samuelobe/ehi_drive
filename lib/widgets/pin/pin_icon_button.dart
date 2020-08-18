import 'package:ehidrive/cubit/pin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinIconButton extends StatelessWidget {
  final Icon icon;
  final void Function() onPressed;
  const PinIconButton({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCubit, String>(
      builder: (context, state) {
        return InkWell(
          enableFeedback: true,
          onTap: onPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(child: icon),
              Container(
                 height: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.height * 0.15,
              )
            ],
          ),
        );
      },
    );
  }
}
