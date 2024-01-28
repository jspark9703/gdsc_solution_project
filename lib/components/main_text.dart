import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  final String mainText;

  MainText({required this.mainText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 90, left: 24),
        child: Text(
          mainText,
          style: TextStyle(
            color: Color(0xFF777C89),
            fontSize: 24,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.50,
          ),
        ));
  }
}
