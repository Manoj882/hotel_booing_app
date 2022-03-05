import 'package:flutter/material.dart';

class GeneralChooseAccountPage extends StatefulWidget {
  const GeneralChooseAccountPage(
      {required this.onPressed,
      required this.text,
      required this.accountTitle,
      Key? key})
      : super(key: key);

  final String text;
  final String accountTitle;
  final Function()? onPressed;

  @override
  _GeneralChooseAccountPageState createState() =>
      _GeneralChooseAccountPageState();
}

class _GeneralChooseAccountPageState extends State<GeneralChooseAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        TextButton(
          onPressed: widget.onPressed,
          child: Text(
            widget.accountTitle,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Color(0xff4caf50),
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
