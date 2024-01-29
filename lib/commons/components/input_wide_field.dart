import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/const/color.dart';

class CustomTextWideField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final Icon? prefixIcons;

  const CustomTextWideField({
    required this.controller,
    required this.hintText,
    required this.obscure,
    this.prefixIcons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        labelStyle: const TextStyle(color: INPUT_LABEL_COLOR),
        hintStyle: const TextStyle(color: INPUT_LABEL_COLOR),
        prefixIcon: prefixIcons,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(width: 1, color: BORDER_COLOR),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(width: 1, color: BORDER_COLOR),
        ),
      ),
    );
  }
}
