import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/commons/component/custom_text_field.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/screens/register_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isChecked = false;

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '쇼핑 안내견 서비스를 이용하시려면,\n' '로그인을 진행해 주세요.',
                  style: TextStyle(
                    fontSize: 24,
                    color: GRAY_COLOR,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  '이메일',
                  style: TextStyle(fontSize: 20, color: GRAY_COLOR),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                    controller: _emailController,
                    hintText: '이메일을 입력해 주세요.',
                    obscure: false,
                    prefixIcons: Icon(Icons.email)),
                const SizedBox(height: 16),
                Text(
                  '비밀번호',
                  style: TextStyle(fontSize: 20, color: GRAY_COLOR),
                ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: '비밀번호를 입력해 주세요',
                  obscure: true,
                  prefixIcons: Icon(Icons.lock),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                          activeColor: TEXTFIELD_COLOR,
                          checkColor: CHECK_COLOR,
                        ),
                        Text(
                          '아이디 저장',
                          style: TextStyle(color: GRAY_COLOR),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '아이디/비밀번호 찾기',
                        style: TextStyle(color: GRAY_COLOR),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                    onPressed: () {
                      AuthController().logIn(_emailController.text.trim(),
                          _passwordController.text.trim());
                    },
                    label: '로그인',
                    backgroundColor: GREEN_COLOR,
                    textColor: Colors.white),
                const SizedBox(height: 32,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "아직 회원이 아니신가요?",
                      style: TextStyle(color: GRAY_COLOR),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(()=>RegisterScreen());
                      },
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
