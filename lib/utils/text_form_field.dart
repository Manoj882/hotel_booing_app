import 'package:flutter/material.dart';

import '/constants/constant.dart';





class InputTextField extends StatefulWidget{
  const InputTextField({
    required this.title,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    required this.prefixIcon,
    required this.validate,
    
    Key? key}) : super(key: key);

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
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        prefixIcon: widget.prefixIcon,
        hintText: widget.title,
        hintStyle: bodyTextStyle,
        
      ),
      validator: widget.validate,
    );
  }
}
