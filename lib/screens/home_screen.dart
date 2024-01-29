import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/screens/search_screen.dart';
import 'package:get/get.dart';

class AppHomeScreen extends StatelessWidget {
  AppHomeScreen({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the App!',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 32),
            CustomButton(
                onPressed: () {
                  Get.to(const SearchScreen());
                },
                label: "검색하기",
                backgroundColor: GREEN_COLOR,
                textColor: Colors.white),
            CustomButton(
                onPressed: () {
                  Get.to(const SearchScreen());
                },
                label: "프로필수정",
                backgroundColor: GREEN_COLOR,
                textColor: Colors.white),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 0),
    );
  }
}
