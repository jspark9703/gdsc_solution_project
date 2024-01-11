import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/controllers/Authcontroller.dart';
import 'package:gdsc_solution_project/pages/register_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                //TODO 로그인
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 32),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("이메일로 간단하게 회원가입"),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(RegisterPage());
                    },
                    child: const Text('register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
