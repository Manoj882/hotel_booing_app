import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

class GeneralTextButton extends StatelessWidget {
  const GeneralTextButton({
    required this.buttonName,
    required this.bgColor,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: basePadding,
      child: SizedBox(
        height: SizeConfig.height * 6,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: () {},
          child: Text(
            buttonName,
            style: Theme.of(context).textTheme.headline6,
          ),
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
          ),
        ),
      ),
    );
  }
}
