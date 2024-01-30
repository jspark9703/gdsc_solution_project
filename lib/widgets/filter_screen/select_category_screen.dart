import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/detail_list_screen.dart';
import 'package:gdsc_solution_project/screens/filter_screen.dart';
import 'package:get/get.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {

    List<String> categorys = ['1kg 이하', '1~3kg', '3~5kg', '5kg 이상'];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '원하시는 총 중량을 선택해 주세요.',
              style: TextStyle(
                fontSize: 24,
                color: GRAY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              color: const Color(0xFFFAFAFA),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '총 중량',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          '선택',
                          style: TextStyle(
                            fontSize: 20,
                            color: CHECKBOX_COLOR,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...categorys.asMap().entries.map((entry) => CustomRadio(entry.value, entry.key)).toList(),                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  onPressed: () {
                    Get.to(const FilterScreen());
                  },
                  label: '필터 추가하기',
                  backgroundColor: LIGHT_GREEN_COLOR,
                  textColor: GREEN_COLOR,
                ),
                const SizedBox(
                  height: 32,
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
          ],
        ),
      ),
    );
  }

  RadioListTile CustomRadio(String title, int value) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: selectedValue,
      onChanged: (newValue) {
        setState(() {
          selectedValue = newValue as int;
        });
      },
      activeColor: CHECKBOX_COLOR,
    );
  }
}
