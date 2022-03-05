import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
class InputTextField extends StatefulWidget {
  const InputTextField(
      {required this.title,
      required this.textInputType,
      required this.textInputAction,
      required this.controller,
      required this.prefixIcon,
      required this.validate,
      Key? key})
      : super(key: key);

  final String title;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Icon prefixIcon;
  final String? Function(String?)? validate;
  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            SizeConfig.height * 2,
          ),
        ),
        prefixIcon: widget.prefixIcon,
        hintText: widget.title,
        hintStyle: Theme.of(context).textTheme.subtitle1,
      ),
      validator: widget.validate,
    );
  }
}
