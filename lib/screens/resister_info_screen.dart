import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/input_wide_field.dart';
import 'package:gdsc_solution_project/commons/components/main_text.dart';
import 'package:gdsc_solution_project/commons/guidemessage.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/models/user_url.dart';
import 'package:get/get.dart';
import 'package:gdsc_solution_project/commons/components/input_field.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import '../provider/Authcontroller.dart';

class ResisterInfoScreen extends StatefulWidget {
  const ResisterInfoScreen({super.key});

  @override
  State<ResisterInfoScreen> createState() => _ResisterInfoScreenState();
}

class _ResisterInfoScreenState extends State<ResisterInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _considerationController =
      TextEditingController();

  AuthController authController = Get.put(AuthController());
  bool? _isMessageOn;
  User? currentUser;

  void fetchProfile() async {
    currentUser =
        await DBService().readProfile(AuthController().getCurrentUser());
    _isMessageOn = currentUser?.showMessage ?? true;
    _nameController.text = currentUser?.userName ?? "";
    _classController.text = currentUser?.userClass ?? '';
    _considerationController.text = currentUser?.userInfo ?? '';
    setState(() {});
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            GuideMessage(text: '원활한 서비스 이용을 위해 추가정보를 입력하여주세요.'),
            SizedBox(
              height: 10,
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
                    hintText:
                        '닉네임을 입력해 주세요.',
                    obscure: false,

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '장애등급',
                    style: TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
                  ),
                  CustomTextField(
                    controller: _classController,
                    hintText:
                        '장애등급을 입력해 주세요',
                    obscure: false,
                  ),
                  SizedBox(
                    height: 10,
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
                    obscure: false,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  onPressed: () {
                    DBService().updateProfile(
                        AuthController().getCurrentUser(),
                        User(
                            userName: _nameController.text,
                            userClass: _classController.text,
                            userInfo: _considerationController.text,
                            showMessage: true));
                     AuthController().completeRegistration();   
                  },
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
    );
  }
}
