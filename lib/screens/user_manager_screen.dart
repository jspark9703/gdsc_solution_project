import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/input_wide_field.dart';
import 'package:gdsc_solution_project/commons/components/main_text.dart';
import 'package:gdsc_solution_project/commons/guidemessage.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/models/user_url.dart';
import 'package:gdsc_solution_project/provider/user_info_provider.dart';
import 'package:gdsc_solution_project/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:gdsc_solution_project/commons/components/input_field.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import 'package:logger/logger.dart';
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

  User? currentUser;

  @override
  void initState() {
    super.initState();
    fetchProfile();
        Get.lazyPut(() => UserInfoController());

  }

  void fetchProfile() async {
    currentUser =
        await DBService().readProfile(AuthController().getCurrentUser());
    _nameController.text = currentUser?.userName ?? "";
    _classController.text = currentUser?.userClass ?? '';
    _considerationController.text = currentUser?.userInfo ?? '';
  }

  @override
  Widget build(BuildContext context) {

    UserInfoController userController = Get.find<UserInfoController>();
  
    return Scaffold(
      appBar: AppBar(title: Text("사용설정")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
             Text(
               '사용 설정을 변경할 수 있습니다. \n안내메세지 관리, 사용사 정보 변경',
              style: const TextStyle(
                fontSize: 24,
                color: GRAY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(()=>ListTile(
              
              title: Text(
                userController.user.value!.showMessage! ? '안내메세지 끄기' : '안내메세지 켜기',
                style: TextStyle(fontSize: 20, color: INPUT_LABEL_COLOR),
              ),
              trailing: Switch(
                value: userController.user.value!.showMessage!,
                onChanged: (bool newValue) {
                  userController.updateShowMessage(newValue);
                },
              ),
            ),),
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
                            showMessage: userController.user.value!.showMessage!!));

                            userController.updateShowMessage(userController.user.value!.showMessage!);

                    Get.to(()=>HomeScreen());
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
      bottomNavigationBar: AppNavigationBar(currentIndex: 3),
    );
  }
}
