import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/component/custom_button.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/select_button_screen.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '000주인님, 안녕하세요!\n어떤 제품을 찾고 계세요?\n검색어를 밑에 입력해주세요.',
              style: TextStyle(
                fontSize: 24,
                color: GREY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '식품 이름을 검색해보세요',
                // fillColor: Colors.white,
                // filled: true,
                labelStyle: TextStyle(color: GREY_COLOR),
                hintStyle: TextStyle(color: GREY_COLOR),
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: GREY_COLOR),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: GREY_COLOR, width: 0.5),
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                Get.to(SelectButtonScreen());
              },
              label: '다음으로 넘어가기',
              backgroundColor: GREEN_COLOR,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
