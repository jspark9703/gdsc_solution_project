import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/input_wide_field.dart';
import 'package:gdsc_solution_project/commons/components/main_text.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:get/get.dart';
import 'package:gdsc_solution_project/commons/components/input_field.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import '../provider/Authcontroller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _considerationController =
  TextEditingController();

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainText(mainText: '더 편한 이용을 위해서,\n이용자 등록을 해주세요.'),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '닉네임',
                      style: TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
                    ),
                    CustomTextField(
                      controller: _nameController,
                      hintText: '닉네임을 입력해 주세요.',
                      obscure: false,
                    ),
                    const Text(
                      '장애등급',
                      style: TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
                    ),
                    CustomTextField(
                      controller: _classController,
                      hintText: '장애등급을 입력해 주세요',
                      obscure: true,
                    ),
                    const Text(
                      '식품을 고를 때,\n중요하게 생각하는 것이 무엇인가요?',
                      style: TextStyle(
                          fontSize: 20,
                          color: GRAY_COLOR,
                          fontWeight: FontWeight.w600),
                    ),
                    CustomTextWideField(
                      controller: _considerationController,
                      hintText: '(예시)\n매운 것을 못 먹음, 전자레인지 조리 선호,\n유제품 알러지',
                      obscure: true,
                    ),
                  ],
                ),
              )
          ),
          CustomButton(onPressed: (){}, label: '등록하기', backgroundColor: GREEN_COLOR, textColor: Colors.white,),
          SizedBox(height: 150.0),
        ],
      ),
    );
  }
}
