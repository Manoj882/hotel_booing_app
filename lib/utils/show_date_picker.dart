import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDatePicker{
  customDatePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }
}