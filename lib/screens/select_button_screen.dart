import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/select_filter_screen.dart';
import 'package:get/get.dart';

class SelectButtonScreen extends StatelessWidget {
  const SelectButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '상품을 어떻게 찾고 싶으신가요?\n조건을 설정하여 상품을 찾을 수 있는\n\'필터로 검색하기\'\n또는 이름으로만 검색하는\n\'바로 검색하기\'중 선택해 주세요.',
              style: TextStyle(
                fontSize: 24,
                color: GREY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  onPressed: () {
                    Get.to(SelectFilterScreen());
                  },
                  label: '필터로 검색하기',
                  backgroundColor: LIGHT_GREEN_COLOR,
                  textColor: GREEN_COLOR,
                ),
                SizedBox(
                  height: 32,
                ),
                CustomButton(
                  onPressed: () {
                    Get.to(SelectButtonScreen());
                  },
                  label: '바로 검색하기',
                  backgroundColor: GREEN_COLOR,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
