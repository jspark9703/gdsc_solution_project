import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/const/color.dart';

class TextTitleBox extends StatelessWidget {
  final String? mainText;
  final String? subText;
  final Widget? mainIcon;
  final String? mode;

  TextTitleBox({this.mainText, this.mainIcon, this.subText, this.mode = "main"});

  @override
  Widget build(BuildContext context) {
    Color textColor = mode == "sub" ? DETAIL_COLOR : BLACK_COLOR;
    double fontSize = mode == "sub" ? 16 : 20;

    return Padding(
      padding: mode == "sub"
          ? const EdgeInsets.symmetric(vertical: 10)
          : const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (mainText != null)
            Text(
              mainText!,
              style: TextStyle(
                color: BLACK_COLOR,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (mainIcon != null) mainIcon!,
          if (subText != null)
            Text(
              subText!,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}