import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/components/text_contents.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:get/get.dart';

class DetailListScreen extends StatelessWidget {
  const DetailListScreen({this.kwds, this.isBestUrl, super.key});

  final String? kwds;
  final String? isBestUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("상품 리스트")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder(
          future: ApiService().searchProd(kwds, isBestUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: TextContentBox(mainText: "상품이 준비중입니다. 잠시만 기다려주세요"));
            } else if (snapshot.hasError) {
              return Text("오류가 발생했습니다\n${snapshot.error}");
            } else if (snapshot.hasData) {
              // 데이터 타입 처리가 필요합니다. 예를 들어, snapshot.data를 적절한 타입으로 캐스팅
              final data = snapshot.data!; // 이 부분은 실제 데이터 타입에 맞게 수정해야 합니다.

              return Semantics(
                container: true,
                label: "상품리스트",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        '$kwds 검색결과입니다.\n 총 ${data.prods.length} 상품이 준비되었습니다.',
                        style: const TextStyle(
                          fontSize: 24,
                          color: GRAY_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.prods.length,
                        // 이 부분은 실제 데이터 타입에 맞게 수정해야 합니다.
                        itemBuilder: (context, index) {
                          final prod = data
                              .prods[index]; // 이 부분은 실제 데이터 타입에 맞게 수정해야 합니다.
                          final url = prod.link;
                          return Semantics(
                            button: true,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => DetailScreen(prod: prod));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.grey)),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${prod.name} (${prod.ratingNum})',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (prod.dimm != '')
                                      Text(
                                        prod.dimm,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey[500],
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    Text(
                                      prod.price,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text("데이터가 없습니다.");
            }
          },
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 1),
    );
  }
}
