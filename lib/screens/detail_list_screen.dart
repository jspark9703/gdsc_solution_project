import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/components/detail_list/contents.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:get/get.dart';
import '../commons/components/main_text.dart';

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
                return Text("오류가 발생했습니다: ${snapshot.error}");
              } else if (snapshot.hasData) {
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
                        margin: EdgeInsets.only(bottom: 20),
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
    );
  }
}
