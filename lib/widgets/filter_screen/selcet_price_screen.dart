import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/detail_list_screen.dart';
import 'package:gdsc_solution_project/screens/filter_screen.dart';
import 'package:get/get.dart';

class SelectPriceScreen extends StatefulWidget {
  const SelectPriceScreen({super.key});

  @override
  State<SelectPriceScreen> createState() => _SelectPriceScreenState();
}

class _SelectPriceScreenState extends State<SelectPriceScreen> {
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
              '원하시는 가격대가 있으신가요?\n최소와 최대 금액을 입력해 주세요.',
              style: TextStyle(
                fontSize: 24,
                color: GRAY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: GRAY_COLOR),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: GRAY_COLOR),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: GRAY_COLOR, width: 0.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  '~',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: GRAY_COLOR),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: GRAY_COLOR),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: GRAY_COLOR, width: 0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  '원',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
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
}
