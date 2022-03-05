import 'package:flutter/material.dart';

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
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.indigo,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
