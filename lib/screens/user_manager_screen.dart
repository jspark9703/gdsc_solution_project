import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/input_wide_field.dart';
import 'package:gdsc_solution_project/commons/components/main_text.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/models/user_url.dart';
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
            const MainText(mainText: '사용 설정을 변경할 수 있습니다. \n 안내메세지 , 사용사 정보 변경'),
            const SizedBox(
              height: 10,
            ),
            Semantics(
              readOnly: true,
              child: ListTile(
                title: Text(
                  _isMessageSelected ? '안내메세지 끄기' : '안내메세지 켜기',
                  style:
                      const TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
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
            ),
            const SizedBox(height: 50),
            const Text(
              '원활한 서비스 이용을 위해 추가정보를 입력하여주세요.',
              style: TextStyle(
                fontSize: 24,
                color: GRAY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
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
                  const Text(
                    '장애등급',
                    style: TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
                  ),
                  Semantics(
                    expanded: true,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '식품을 고를 때,\n중요하게 생각하는 것이 무엇인가요?',
                    style: TextStyle(
                        fontSize: 20,
                        color: GRAY_COLOR,
                        fontWeight: FontWeight.w600),
                  ),
                  Semantics(
                    textField: true,
                    child: CustomTextWideField(
                      controller: _considerationController,
                      hintText: '(예시)\n매운 것을 못 먹음, 전자레인지 조리 선호,\n유제품 알러지',
                      obscure: false,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  button: true,
                  child: CustomButton(
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
                ),
                const SizedBox(
                  height: 30,
                ),
                Semantics(
                  button: true,
                  child: CustomButton(
                    onPressed: () {
                      AuthController().logout();
                    },
                    label: '로그아웃',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 3),
    );
  }
}
