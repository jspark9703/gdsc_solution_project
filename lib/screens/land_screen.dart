import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/components/sub_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/controllers/Authcontroller.dart';
import 'package:get/get.dart';

class LandScreen extends StatelessWidget {
  LandScreen({super.key});

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: USER_COLOR,
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/land.png', fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 150,
            child: SubButton(
              onPressed: () {}, // 로그인,,, 혹은 자동 로그인 되면 홈으로 가도록 구현
              buttonText: '가입 하기',
            ),
          ),
        ],
      ),
    );
  }
}
