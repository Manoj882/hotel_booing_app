import 'package:flutter/material.dart';
import '/constants/constant.dart';

class GeneralSubmitButton extends StatefulWidget {
  const GeneralSubmitButton(
      {required this.bottonTitle, required this.onPressed, Key? key})
      : super(key: key);

  final String bottonTitle;
  final Function()? onPressed;
  @override
  State<GeneralSubmitButton> createState() => _GeneralSubmitButtonState();
}

class _GeneralSubmitButtonState extends State<GeneralSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color(0xffff2d55),
      ),
      child: Center(
        child: FlatButton(
          onPressed: widget.onPressed,
          child: Text(
            widget.bottonTitle,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
