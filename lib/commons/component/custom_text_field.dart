import 'package:flutter/material.dart';

import '../../const/color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final Icon prefixIcons;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.obscure,
    required this.prefixIcons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: TEXTFIELD_COLOR,
        filled: true,
        border: InputBorder.none,
        labelStyle: const TextStyle(color: GRAY_COLOR),
        hintStyle: const TextStyle(color: GRAY_COLOR),
        prefixIcon: prefixIcons,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscure,
    );
  }
}
