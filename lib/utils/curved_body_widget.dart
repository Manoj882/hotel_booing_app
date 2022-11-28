import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

class CurvedBodyWidget extends StatelessWidget {
  const CurvedBodyWidget({required this.widget, Key? key }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.height * 100,
        width: SizeConfig.width * 100,
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          
          ),
        ),
        padding: basePadding,
        child: widget);
  }
}