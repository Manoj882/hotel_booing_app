import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

class OnBoardNavigationButton extends StatelessWidget {
  const OnBoardNavigationButton(
      {
        required this.name, 
        required this.onPressed, 
        Key? key})
      : super(key: key);
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(SizeConfig.height * 1),
      splashColor: Colors.black12,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.indigo,
                fontSize: SizeConfig.width * 4,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
