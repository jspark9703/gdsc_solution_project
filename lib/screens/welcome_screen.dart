import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/controllers/Authcontroller.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the App!',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 32),
            Image.asset('assets/images/welcome.jpg'),
            TextButton(
                onPressed: () {
                  authController.logout();
                },
                child: const Text("logout"))
          ],
        ),
      ),
    );
  }
}
