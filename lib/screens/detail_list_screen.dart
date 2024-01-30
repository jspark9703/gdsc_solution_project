import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/detail_list/contents.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:get/get.dart';
import '../commons/components/main_text.dart';

class DetailListScreen extends StatelessWidget {
  const DetailListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(mainText: '00 제품 00 카테고리\n추천 상품 리스트입니다.'),
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {
                  Get.to(DetailScreen());
                },
                child: Contents(),
              ),
              InkWell(
                onTap: () {
                  Get.to(DetailScreen());
                },
                child: Contents(),
              ),
              InkWell(
                onTap: () {
                  Get.to(DetailScreen());
                },
                child: Contents(),
              ),
              InkWell(
                onTap: () {
                  Get.to(DetailScreen());
                },
                child: Contents(),
              ),
              SizedBox(height: 150.0),
            ],
          ),
        ),
      ),
    );
  }
}
