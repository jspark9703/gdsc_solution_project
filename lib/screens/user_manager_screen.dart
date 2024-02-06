import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/input_wide_field.dart';
import 'package:gdsc_solution_project/commons/components/main_text.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:get/get.dart';
import 'package:gdsc_solution_project/commons/components/input_field.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import '../provider/Authcontroller.dart';

class UserManagerScreen extends StatefulWidget {
  const UserManagerScreen({super.key});

  @override
  State<UserManagerScreen> createState() => _UserManagerScreenState();
}

class _UserManagerScreenState extends State<UserManagerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _considerationController =
      TextEditingController();

  AuthController authController = Get.put(AuthController());
  bool _isMessageSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            MainText(mainText: '사용 설정을 변경할 수 있습니다. \n 안내메세지 , 사용사 정보 변경'),
                              SizedBox(height: 10,),

            ListTile(
      title: Text(
                    _isMessageSelected? '안내메세지 끄기':'안내메세지 켜기',
                    style: TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
                  ),
      trailing: Switch(
        value: _isMessageSelected,
        onChanged: (bool newValue) {
          setState(() {
            _isMessageSelected = newValue;
          });
        },
      ),
    ),
            Expanded(
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
                  SizedBox(height: 10,),
                  const Text(
                    '장애등급',
                    style: TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
                  ),
                  CustomTextField(
                    controller: _classController,
                    hintText: '장애등급을 입력해 주세요',
                    obscure: true,
                  ),
                  SizedBox(height: 10,),
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
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  onPressed: () {},
                  label: '변경하기',
                  backgroundColor: GREEN_COLOR,
                  textColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 150.0),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 3),
    );
  }
}