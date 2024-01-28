import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/screens/home_screen.dart';
import 'package:gdsc_solution_project/screens/login_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => AppHomeScreen());
    }
  }

  void loginWithGoogle() async {
    try {
      await authentication.signInWithRedirect(
        GoogleAuthProvider(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        getErrorSnackBar('user-not-found', 'No user found for that email.', e);
      } else if (e.code == 'wrong-password') {
        getErrorSnackBar(
            'wrong-password', 'Wrong password provided for that user.', e);
      }
    }
  }

  void logIn(String email, password) async {
    try {
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        getErrorSnackBar('user-not-found', 'No user found for that email.', e);
      } else if (e.code == 'wrong-password') {
        getErrorSnackBar(
            'wrong-password', 'Wrong password provided for that user.', e);
      }
    }
  }

  void register(String email, password) async {
    try {
      await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Password",
          'The password provided is too weak.',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'email-already-in-use') {
        getErrorSnackBar(
            "Account exist", 'The account already exists for that email.', e);
      }
    } catch (e) {
      getErrorSnackBar("Password", "Check a password", e);
    }
  }

  void getErrorSnackBar(title, message, e) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      titleText: const Text(
        "Registration is failed",
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(
        e.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void logout() {
    authentication.signOut();
  }
}
