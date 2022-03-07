import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
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
        borderRadius: BorderRadius.circular(
          SizeConfig.height * 2,
        ),
        // color: Color(0xffff2d55),
        color: Color(0xff087f23),
      ),
      child: Center(
        child: TextButton(
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
