import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/screens/home_screen.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:gdsc_solution_project/screens/land_screen.dart';
import 'package:gdsc_solution_project/screens/login_screen.dart';
import 'package:gdsc_solution_project/screens/register_info_screen.dart';
import 'package:gdsc_solution_project/screens/search_screen.dart';
import 'package:gdsc_solution_project/screens/user_manager_screen.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  //TODO 새로고침하면 펄스로 바뀜

  RxBool isRegistered = false.obs; 
  // 사용자 등록 상태를 관리하는 변수
  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => LandScreen());


    } else {


     if (isRegistered.isTrue) {
        Get.offAll(() => HomeScreen()); // 등록이 완료되었다면 홈 화면으로 이동
      } else {

        Get.offAll(() => RegisterInfoScreen()); // 추가 정보 입력 화면으로 이동
      } //RegisterInfoScreen()

    }
  }

// UserManagerScreen에서 호출하여 사용자의 추가 정보 입력이 완료되었음을 표시
  void completeRegistration() {
    isRegistered.value = true; // 추가 정보 입력이 완료되었다면 true로 설정
    Get.offAll(() => HomeScreen()); // 홈 화면으로 이동
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
          completeRegistration();
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

  String getCurrentUser() {
    final User? user = authentication.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      print('No user is signed in.');
      return '';
    }
  }
}
