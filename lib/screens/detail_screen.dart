import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/commons/components/rating_star.dart';
import 'package:gdsc_solution_project/commons/components/text_contents.dart';
import 'package:gdsc_solution_project/commons/components/text_title_box.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.url,super.key});
  String? url;
  @override
  _DetailScreenState createState() => _DetailScreenState();

  
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isDetailVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      //TODO futurebuilder이용해서 디테일 정보 받아오기
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
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
                Padding(
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
                      TextTitleBox(mainText: '가격', subText: '30,600원'),
                      TextTitleBox(mainText: '주요정보'),
                      TextTitleBox(mainText: '리뷰'),
                      TextTitleBox(
                        mainText: '총점',
                        subText: '1,233개 리뷰',
                        mode: 'sub',
                      ),
                      TextTitleBox(
                        mainIcon: StarRating(rating: 3),
                        subText: '4/5 점',
                        mode: 'sub',
                      ),


                  //TODO futurebuilder이용해서 리뷰 정보, 리뷰 요약 받아오기

                      TextTitleBox(
                        mainText: '종합 리뷰',
                        mode: 'sub',
                      ),
                      TextContentBox(
                        mainText: '곰곰 고추장 제육 불고기는...',
                      ),
                      Visibility(
                        visible: _isDetailVisible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitleBox(
                              mainText: '장점',
                              mode: 'sub',
                            ),
                            TextContentBox(
                              mainText: '맛과 식감: 사용자는 제품의 맛을 극찬하며, ...',
                            ),
                            TextTitleBox(
                              mainText: '단점',
                              mode: 'sub',
                            ),
                            TextContentBox(
                              mainText:
                                  '수입산 고기 사용: 몇몇 리뷰어들은 수입산 고기를 사용한 것이 아쉽다고 언급했으나...',
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 12.0,
                          ),
                          CustomButton(
                            onPressed: () {
                              setState(() {
                                _isDetailVisible = !_isDetailVisible; // 상태 업데이트
                              });
                            },
                            label: _isDetailVisible ? '리뷰 요약보기' : '리뷰 자세히 보기',
                            backgroundColor: LIGHT_GREEN_COLOR,
                            textColor: GREEN_COLOR,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          CustomButton(
                            onPressed: () {},
                            label: '사이트 확인하기',
                            backgroundColor: GREEN_COLOR,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
