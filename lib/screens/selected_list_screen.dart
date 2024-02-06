import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SelectedListScreen extends StatelessWidget {
  SelectedListScreen({ super.key});
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
                return Text("오류가 발생했습니다: ${snapshot.error}");
              } else if (snapshot.hasData) {

                Logger().d(snapshot.data!.prods);
                return ListView.builder(
                  itemCount: snapshot.data!.prods.length,
                  itemBuilder: (context, index) {
                    final prod = snapshot.data!.prods[index];
                    final url = prod.link;
                    return InkWell(
                      onTap: () {
                        Get.to(DetailScreen(prod: prod,));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child:
                            Text(prod.name), // 여기서 prod 객체의 속성을 사용하여 위젯을 구성합니다.
                      ),
                    );
                  },
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