import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/guidemessage.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/models/filter_list.dart';
import 'package:gdsc_solution_project/screens/best_list_screen.dart';
import 'package:get/get.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final List<Filter> filters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("인기상품")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<FilterList>(
            future:
                ApiService().getBestFilters(), // 비동기 작업으로 FilterList를 가져옵니다.
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // 에러가 발생한 경우 에러 메시지를 표시합니다.
                return Text('Error: ${snapshot.error}');
              } else {
                // 데이터가 성공적으로 로드된 경우 UI를 구성합니다.
                filters = snapshot.data!.filterList;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GuideMessage(
                        text:
                            '카테고리 별 인기상품을 확인해보세요!\n 총 ${filters.length}개의 카테고리가 준비되어 있습니다.'),
                    Semantics(
                      container: true,
                      label: '카테고리 리스트',
                      child: Column(
                        children: [
                          ...filters
                              .map(
                                (filter) => CustomTextButton(
                                  filter.title, // Filter 모델의 title 필드를 사용합니다.
                                  () {
                                    Get.to(BestListScreen(
                                      isBestUrl: filter.url,
                                      title: filter.title,
                                    ));
                                  },
                                ),
                              )
                              .toList(),
                          const Divider(
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 1),
    );
  }

  Column CustomTextButton(String label, VoidCallback onPressed) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
        ),
        TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
