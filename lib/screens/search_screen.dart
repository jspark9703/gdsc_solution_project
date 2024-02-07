import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/component/custom_button.dart';
import 'package:gdsc_solution_project/commons/guidemessage.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/screens/detail_list_screen.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  String? nickname;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    nickname = await DBService().getUserName();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             GuideMessage(text: "${nickname} 주인님, 어떤 제품을 찾고 계세요? \n검색창에 검색어를 입력해주세요."),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: '식품 이름을 검색해보세요',
                // fillColor: Colors.white,
                // filled: true,
                labelStyle: TextStyle(color: GRAY_COLOR),
                hintStyle: TextStyle(color: GRAY_COLOR),
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: GRAY_COLOR),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: GRAY_COLOR, width: 0.5),
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                Get.to( DetailListScreen(kwds: _searchController.text,));
              },
              label: '검색하기',
              backgroundColor: GREEN_COLOR,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 1),
    );
  }
}
