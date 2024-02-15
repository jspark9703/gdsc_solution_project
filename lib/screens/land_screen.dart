import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/screens/login_screen.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  button: true,
                  child: CustomButton(
                    onPressed: () {
                      Get.to(
                        const LoginScreen(),
                      );
                    },
                    label: '시작하기',
                    backgroundColor: GREEN_COLOR,
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
