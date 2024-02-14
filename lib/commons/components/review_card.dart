import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/models/review_list.dart';

class ReviewCard extends StatelessWidget {
  final ReviewList reviewList;

  const ReviewCard({required this.reviewList, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        color: Colors.white,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const PageScrollPhysics(),
                  itemCount: reviewList.reviewList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: TEXTFIELD_COLOR,
                      width: constraint.maxWidth,
                      height: constraint.maxHeight * 0.8,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.person, color: BLACK_COLOR),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                reviewList.reviewList[index].name,
                                style: const TextStyle(color: BLACK_COLOR),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 24.0,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviewList.reviewList[index].review,
                                    style: const TextStyle(color: BLACK_COLOR),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
