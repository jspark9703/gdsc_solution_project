import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/detail_list_screen.dart';
import 'package:gdsc_solution_project/widgets/filter_screen/selcet_price_screen.dart';
import 'package:gdsc_solution_project/widgets/filter_screen/select_category_screen.dart';
import 'package:get/get.dart';

class SelectFilterScreen extends StatefulWidget {
  //final String item;

  const SelectFilterScreen({super.key});

  @override
  State<SelectFilterScreen> createState() => _SelectFilterScreenState();
}

class _SelectFilterScreenState extends State<SelectFilterScreen> {
  List<String> filters = ['가격', '개당 중량', '총 중량', '조리 방법'];

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
              '조건은 설정할 필터를 선택해 주세요.\n필터는 총 0가지입니다.',
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
                          if(filter == '가격'){
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
