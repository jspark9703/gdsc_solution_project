import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:gdsc_solution_project/screens/filter_screen.dart';
import 'package:get/get.dart';

class SearchOrFilterScreen extends StatelessWidget {
  const SearchOrFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '상품을 어떻게 찾고 싶으신가요?\n조건을 설정하여 상품을 찾을 수 있는\n\'필터로 검색하기\'\n또는 이름으로만 검색하는\n\'바로 검색하기\'중 선택해 주세요.',
              style: TextStyle(
                fontSize: 24,
                color: GRAY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  onPressed: () {
                    Get.to(const FilterScreen());
                  },
                  label: '필터로 검색하기',
                  backgroundColor: LIGHT_GREEN_COLOR,
                  textColor: GREEN_COLOR,
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomButton(
                  onPressed: () {
                    Get.to(DetailScreen());
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
