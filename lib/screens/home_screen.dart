import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/controllers/Authcontroller.dart';
import 'package:get/get.dart';
import 'package:gdsc_solution_project/commons/components/main_text.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: MainText(
              mainText: '000 주인님, 반갑습니다.\n무엇을 도와드릴까요?\n저희 어플의 기능을 골라주세요.',
            ),
          ),
          SizedBox(height: 94.0),
          Flexible(
            child: Column(
              children: [
                Flexible(
                  child: CustomButton(
                    onPressed: () {},
                    label: '쇼핑 안내견과 음식 검색하기',
                    backgroundColor: LIGHT_GREEN_COLOR,
                    textColor: GREEN_COLOR,
                  ),
                ),
                Flexible(
                  child: CustomButton(
                    onPressed: () {},
                    label: '최근 검색 목록 확인',
                    backgroundColor: LIGHT_GREEN_COLOR,
                    textColor: GREEN_COLOR,
                  ),
                ),
                Flexible(
                  child: CustomButton(
                    onPressed: () {},
                    label: '프로필 설정',
                    backgroundColor: LIGHT_GREEN_COLOR,
                    textColor: GREEN_COLOR,
                  ),
                ),
                Flexible(
                  child: CustomButton(
                    onPressed: () {},
                    label: '쇼핑 안내견 사용법',
                    backgroundColor: LIGHT_GREEN_COLOR,
                    textColor: GREEN_COLOR,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 150.0),
        ],
      ),
    );
  }
}
