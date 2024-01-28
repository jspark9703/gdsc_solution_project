import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/const/color.dart';

class SubButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  SubButton({required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 66,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(SUB_COLOR),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                shadowColor: MaterialStateProperty.all(SHADOW_COLOR),
                elevation: MaterialStateProperty.all(4),
              ),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 24,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}