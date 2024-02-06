import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import 'package:gdsc_solution_project/commons/components/rating_star.dart';
import 'package:gdsc_solution_project/commons/components/text_contents.dart';
import 'package:gdsc_solution_project/commons/components/text_title_box.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:get/get.dart';

class DetailScreen extends StatefulWidget {
  final String? url;

  const DetailScreen({Key? key, this.url}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isDetailVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ApiService().prodDetail(widget.url!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("오류가 발생했습니다\n${snapshot.error}");
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            // 아래의 product 변수 타입과 사용 방식은 실제 반환되는 데이터 타입에 맞게 적절히 조정 필요
             return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(product.prodImgUrl, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    color: BLACK_COLOR,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.subTitle,
                                  style: TextStyle(
                                    color: DETAIL_COLOR,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_outline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '가격',
                              style: TextStyle(
                                color: BLACK_COLOR,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (product.dimmPrice != '') ...[
                              Text(
                                product.dimmPrice,
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(
                                product.price,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ] else ...[
                              Text(
                                product.price,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: BLACK_COLOR,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '주요정보',
                          style: TextStyle(
                            color: BLACK_COLOR,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...product.details.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.itemCate,
                                  style: const TextStyle(
                                    color: DETAIL_COLOR,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 24.0),
                                Text(
                                  e.itemName,
                                  style: const TextStyle(
                                    color: DETAIL_COLOR,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (e.itemContent.isNotEmpty)
                                  Text(
                                    e.itemContent,
                                    style: const TextStyle(
                                      color: DETAIL_COLOR,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  // 리뷰 섹션 등 나머지 UI 구성은 이전 예시와 동일
                Visibility(
                    visible: _isDetailVisible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 상세 정보 및 리뷰 관련 위젯
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            _isDetailVisible = !_isDetailVisible;
                          });
                        },
                        label: _isDetailVisible ? '리뷰 요약보기' : '리뷰 자세히 보기',
                        backgroundColor: LIGHT_GREEN_COLOR,
                        textColor: GREEN_COLOR,
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
            );
          } else {
            return const Text('데이터가 없습니다.');
          }
        },
      ),
      bottomNavigationBar:  AppNavigationBar(currentIndex: 2),
    );
  }
}