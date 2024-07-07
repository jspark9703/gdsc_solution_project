import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/input_wide_field.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/models/user_url.dart';
import 'package:get/get.dart';
import 'package:gdsc_solution_project/commons/components/input_field.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import '../provider/Authcontroller.dart';

class RegisterInfoScreen extends StatefulWidget {
  const RegisterInfoScreen({super.key});

  @override
  State<RegisterInfoScreen> createState() => _RegisterInfoScreenState();
}

class _RegisterInfoScreenState extends State<RegisterInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _considerationController =
      TextEditingController();

  bool _isMessageSelected = true; // 기본값으로 true 설정
  User? currentUser;
  String? _selectedClass;

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    fetchProfile(); // 프로필 정보 불러오기
  }

  void fetchProfile() async {
    currentUser =
        await DBService().readProfile(AuthController().getCurrentUser());
    _isMessageSelected = currentUser?.showMessage ?? true;
    _nameController.text = currentUser?.userName ?? "";
    _considerationController.text = currentUser?.userInfo ?? '';
    setState(() {
      _selectedClass = currentUser?.userClass ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Semantics(
              readOnly: true,
              child: const Text(
                '원활한 서비스 이용을 위해 추가정보를 입력하여주세요.',
                style: TextStyle(
                  fontSize: 20,
                  color: GRAY_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: Semantics(
                container: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Semantics(
                      readOnly: true,
                      child: const Text(
                        '닉네임',
                        style:
                            TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
                      ),
                    ),
                    Semantics(
                      textField: true,
                      child: CustomTextField(
                        controller: _nameController,
                        hintText: '닉네임을 입력해 주세요.',
                        obscure: false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Semantics(
                      readOnly: true,
                      child: const Text(
                        '장애등급',
                        style:
                            TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
                      ),
                    ),
                    Semantics(
                      expanded: true,
                      enabled: true,
                      label: "장애등급 선택",
                      child: Semantics(
                         expanded: true,
                      enabled: true,
                        child: DropdownButton<String>(
                          hint: const Text("장애등급을 선택하여 주세요."),
                          value: _selectedClass,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedClass = newValue!;
                            });
                          },
                          items: <String>['1등급', '2등급', '3등급', '4등급', '5등급']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Semantics(
                      readOnly: true,
                      child: const Text(
                        '식품을 고를 때,\n중요하게 생각하는 것이 무엇인가요?',
                        style: TextStyle(
                            fontSize: 20,
                            color: GRAY_COLOR,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Semantics(
                      textField: true,
                      label: "다음의 예시를 확인해보세요.",
                      child: CustomTextWideField(

                        controller: _considerationController,
                        hintText: '(예시)\n조리가 간편해야합니다., 너무 맵지 않아야\n 합니다., 땅콩이 들어있지 않아야합니다.',
                        obscure: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  onPressed: () {
                    DBService().updateProfile(
                        authController.getCurrentUser(),
                        User(
                            userName: _nameController.text,
                            userClass: _selectedClass,
                            userInfo: _considerationController.text,
                            showMessage: _isMessageSelected));
                    authController.completeRegistration();
                  },
                  label: '등록하기',
                  backgroundColor: GREEN_COLOR,
                  textColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 150.0),
          ],
        ),
      ),
    );
  }
}
