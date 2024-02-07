import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/const/color.dart';

class GuideMessage extends StatefulWidget {
  GuideMessage({required this.text, super.key});

  String text;

  @override
  State<GuideMessage> createState() => _GuideMessageState();
}

class _GuideMessageState extends State<GuideMessage> {
  bool isMessegeOn = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainSize: true,
      visible: isMessegeOn,
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 24,
          color: GRAY_COLOR,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
