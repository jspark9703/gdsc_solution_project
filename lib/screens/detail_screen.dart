import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/components/main_button.dart';
import 'package:gdsc_solution_project/components/rating_star.dart';
import 'package:gdsc_solution_project/components/sub_button.dart';
import 'package:gdsc_solution_project/components/text_contents.dart';
import 'package:gdsc_solution_project/components/text_title_box.dart';
import 'package:gdsc_solution_project/const/color.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset('assets/images/land.png'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maison Kitsuné',
                    style: TextStyle(
                      color: BLACK_COLOR,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Maison Kitsuné 로고 패치 프린지 니트 스카프',
                    style: TextStyle(
                      color: DETAIL_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                  ),
                ],
              ),
            ),
            TextTitleBox(mainText: '가격', subText: '30,600원'),
            TextTitleBox(mainText: '주요정보'),
            TextTitleBox(mainText: '리뷰'),
            TextTitleBox(mainText: '총점', subText: '1,233개 리뷰', mode: 'sub',),
            TextTitleBox(mainIcon: StarRating(rating: 3), subText: '4/5 점', mode: 'sub',),
            TextTitleBox(mainText: '종합 리뷰', mode: 'sub',),
            TextContentBox(mainText: '곰곰 고추장 제육 불고기는...',),
            TextTitleBox(mainText: '장점', mode: 'sub',),
            TextContentBox(mainText: '맛과 식감: 사용자는 제품의 맛을 극찬하며, ...',),
            TextTitleBox(mainText: '단점', mode: 'sub',),
            TextContentBox(mainText: '수입산 고기 사용: 몇몇 리뷰어들은 수입산 고기를 사용한 것이 아쉽다고 언급했으나...'),
            SizedBox(height: 12.0,),
            SubButton(onPressed: (){}, buttonText: '리뷰 요약보기'),
            SizedBox(height: 12.0,),
            MainButton(onPressed: (){}, buttonText: '사이트 확인하기'),
          ],
        ),
      ),
    );
  }
}
