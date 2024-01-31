import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/detail_list_screen.dart';
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
  List<String> filters = ['베이커리', '샐러드', '오일', '설 선물 세트'];

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
              '특정 카테고리의\n인기상품을 골라주세요',
              style: TextStyle(
                fontSize: 24,
                color: GRAY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                ...filters
                    .map(
                      (filter) => CustomTextButton(
                        filter,
                        () {
                          if (filter == '가격') {
                            Get.to(SelectPriceScreen());
                          } else {
                            Get.to(SelectCategoryScreen());
                          }
                        },
                      ),
                    )
                    .toList(),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
            CustomButton(
              onPressed: () {
                Get.to(DetailListScreen());
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
        Divider(
          color: Colors.black,
        ),
        TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
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
