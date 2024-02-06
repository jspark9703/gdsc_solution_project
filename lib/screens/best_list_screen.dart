import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:get/get.dart';

class BestListScreen extends StatelessWidget {
  BestListScreen({this.kwds, this.isBestUrl, required this.title, super.key});

  String? kwds;
  String? isBestUrl;
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FutureBuilder(
            future: ApiService().searchProd(kwds, isBestUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("오류가 발생했습니다\n ${snapshot.error}");
              } else if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title 카테고리의 베스트 상품 입니다.',
                      style: const TextStyle(
                        fontSize: 24,
                        color: GRAY_COLOR,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.prods.length,
                        itemBuilder: (context, index) {
                          final prod = snapshot.data!.prods[index];
                          final url = prod.link;
                          return InkWell(
                            onTap: () {
                              Get.to(DetailScreen(
                                prod: prod,
                              ));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.grey))),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${prod.name}(${prod.ratingNum})',
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (prod.dimm != '')
                                    Text(
                                      prod.dimm,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey[500],
                                          decoration: TextDecoration.lineThrough),
                                    ),
                                  Text(
                                    prod.price,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ), // 여기서 prod 객체의 속성을 사용하여 위젯을 구성합니다.
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("데이터가 없습니다.");
              }
            },
          )),
    );
  }
}
