import 'package:flutter/material.dart';

import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import 'package:gdsc_solution_project/commons/guidemessage.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/screens/filter_screen.dart';
import 'package:gdsc_solution_project/screens/search_screen.dart';
import 'package:gdsc_solution_project/screens/selected_list_screen.dart';
import 'package:gdsc_solution_project/screens/user_manager_screen.dart';
import 'package:get/get.dart';
import 'package:gdsc_solution_project/commons/components/main_text.dart';
import 'package:logger/logger.dart';

import '../provider/user_info_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());

  String? nickname;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchUserName();
    isLoading = false;
  }

  void fetchUserName() async {
    try {
          nickname = await DBService().getUserName();

    } catch (e) {
      Logger().d(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserInfoController userInfoController=  Get.put(UserInfoController()); 
    return isLoading? Center(child: CircularProgressIndicator(),): Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Obx(() => GuideMessage(text: "안녕하세요.\n${userInfoController.user.value!.userName} 주인님 무엇을 도와드릴까요? \n 총 4가지 기능이 준비되어 있습니다.")) ,
            SizedBox(height: 94.0),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  onPressed: () {
                    Get.to(SearchScreen());
                  },
                  label: '쇼핑 안내견과 음식 검색하기',
                  backgroundColor: LIGHT_GREEN_COLOR,
                  textColor: GREEN_COLOR,
                ),
                SizedBox(height: 24.0),
                CustomButton(
                  onPressed: () {
                    Get.to(FilterScreen());
                  },
                  label: '인기 상품 골라보기',
                  backgroundColor: LIGHT_GREEN_COLOR,
                  textColor: GREEN_COLOR,
                ),
                SizedBox(height: 24.0),
                CustomButton(
                  onPressed: () {
                    Get.to(()=>SelectedListScreen());
                  },
                  label: '찜한 상품 보기',
                  backgroundColor: LIGHT_GREEN_COLOR,
                  textColor: GREEN_COLOR,
                ),
                SizedBox(height: 24.0),
                CustomButton(
                  onPressed: () {
                    Get.to(UserManagerScreen());
                  },
                  label: '사용 설정',
                  backgroundColor: LIGHT_GREEN_COLOR,
                  textColor: GREEN_COLOR,
                ),
                
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 0),
    );


  }
}
