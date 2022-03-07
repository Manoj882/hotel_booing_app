import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

class InputTextField extends StatefulWidget {
  const InputTextField(
      {required this.title,
      required this.textInputType,
      required this.textInputAction,
      required this.controller,
      this.prefixIcon,
      required this.validate,
      this.isObscure = false,
      required this.onFieldSubmitted,
      Key? key})
      : super(key: key);

  final String title;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final bool isObscure;
  final Icon? prefixIcon;
  final String? Function(String?)? validate;
  final Function(String)? onFieldSubmitted;
  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late bool toHide;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toHide = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      obscureText: toHide,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hintText: widget.title,
        hintStyle: Theme.of(context).textTheme.subtitle1,
        suffixIcon: widget.isObscure
            ? IconButton(
                icon: toHide
                    ? Icon(Icons.visibility_outlined)
                    : Icon(Icons.visibility_off_outlined),
                onPressed: () {
                  setState(() {
                    toHide = !toHide;
                  });
                },
              )
            : null,
      ),
      validator: widget.validate,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
