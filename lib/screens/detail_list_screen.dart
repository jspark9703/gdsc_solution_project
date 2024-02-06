import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';

import 'package:gdsc_solution_project/commons/navigation_bar.dart';

import 'package:gdsc_solution_project/const/color.dart';

import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:get/get.dart';

class DetailListScreen extends StatelessWidget {
  DetailListScreen({this.kwds, this.isBestUrl, super.key});

  String? kwds;
  String? isBestUrl;

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
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("오류가 발생했습니다\n ${snapshot.error}");
              } else if (snapshot.hasData) {

                Logger().d(snapshot.data!.prods);

                return ListView.builder(
                  itemCount: snapshot.data!.prods.length,
                  itemBuilder: (context, index) {
                    final prod = snapshot.data!.prods[index];
                    final url = prod.link;
                    return InkWell(
                      onTap: () {
                        Get.to(DetailScreen(url: url,));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child:
                            Text(prod.name), // 여기서 prod 객체의 속성을 사용하여 위젯을 구성합니다.


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$kwds 상품의 추천 리스트 입니다.\n가격과 혜택 여부를\n선택하실 수 있습니다.',
                      style: TextStyle(
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
                                url: url,
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.grey))),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${prod.name}(${prod.ratingNum})',
                                    style: TextStyle(
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
                                    style: TextStyle(
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
                return Text("데이터가 없습니다.");
              }
            },
          )),
          bottomNavigationBar: AppNavigationBar(currentIndex:2 ),
    );
  }
}
