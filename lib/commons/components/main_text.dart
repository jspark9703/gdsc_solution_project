import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  final String mainText;

  const MainText({super.key, required this.mainText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 90),
        child: Text(
          mainText,
          style: const TextStyle(
            color: Color(0xFF777C89),
            fontSize: 24,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.50,
          ),
        ));
  }
}
