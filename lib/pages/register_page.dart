import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/controllers/Authcontroller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Register logic here
                if (_passwordController.text ==
                    _confirmPasswordController.text) {
                  AuthController.instance.register(_emailController.text.trim(),
                      _passwordController.text.trim());
                } else {
                  // Show error message
                  Get.snackbar(
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM,
                      "Confirm password",
                      "비밀번호를 확인해주세요");
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
