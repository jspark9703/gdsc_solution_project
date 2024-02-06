import 'package:flutter/material.dart';

class TextContentBox extends StatelessWidget {
  final String mainText;

  TextContentBox({required this.mainText});

  @override
  Widget build(BuildContext context) {
    return Text(
      mainText,
      style: TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
