import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/guidemessage.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SelectedListScreen extends StatelessWidget {
  SelectedListScreen({ super.key});
  String uid = AuthController().getCurrentUser();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("찜한 상품")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder(
          future: DBService().readLike(uid) ,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              Logger().d(snapshot.error);
              return Center(
                child: Text(
                "찜한 상품이 없습니다.",
                style: const TextStyle(
                  fontSize: 24,
                  color: GRAY_COLOR,
                  fontWeight: FontWeight.bold,
                ),
                            ),
              );
            } else if (snapshot.hasData) {
              // 데이터 타입 처리가 필요합니다. 예를 들어, snapshot.data를 적절한 타입으로 캐스팅
              
              final data = snapshot.data!; // 이 부분은 실제 데이터 타입에 맞게 수정해야 합니다.

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GuideMessage(text: "주인님이 찜한 상품, ${data.length}가지가 준비되었습니다."),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length, // 이 부분은 실제 데이터 타입에 맞게 수정해야 합니다.
                      itemBuilder: (context, index) {
                        final prod = data[index]; // 이 부분은 실제 데이터 타입에 맞게 수정해야 합니다.
                        final url = prod.link;
                        return InkWell(
                          onTap: () {

                            Get.to(() => DetailScreen(prod: prod,isliked: true,));

                           

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.grey)),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                                      decoration: TextDecoration.lineThrough,
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
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 2),
    );
  }
}
