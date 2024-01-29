import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/search_or_filter_screen.dart';
import 'package:gdsc_solution_project/widgets/filter_screen/selcet_price_screen.dart';
import 'package:get/get.dart';

import '../widgets/filter_screen/select_category_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
              '조건은 설정할 필터를 선택해 주세요.\n필터는 총 0가지입니다.',
              style: TextStyle(
                fontSize: 24,
                color: GRAY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                CustomTextButton('가격', () {
                  Get.to(const SelectPriceScreen());
                }),
                CustomTextButton('개당 중량', () {}),
                CustomTextButton('총 중량', () {
                  Get.to(const SelectCategoryScreen());
                }),
                CustomTextButton('조리 방법', () {}),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
            CustomButton(
              onPressed: () {
                Get.to(const SearchOrFilterScreen());
              },
              label: '바로 검색하기',
              backgroundColor: GREEN_COLOR,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Column CustomTextButton(String label, VoidCallback onPressed) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
        ),
        TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
