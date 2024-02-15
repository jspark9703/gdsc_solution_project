import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/models/review_list.dart';

class ReviewCard extends StatefulWidget {
  final ReviewList reviewList;

  const ReviewCard({required this.reviewList, Key? key}) : super(key: key);

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  int _currentIndex = 0;
  late final List<Review> reviews ; // 현재 리뷰 인덱스
 late String currentreview ;


@override
  void initState() {
    reviews = widget.reviewList.reviewList;
    currentreview = reviews[0].review;
    super.initState();
  }
  void _nextReview() {
    setState(() {
      if (_currentIndex < widget.reviewList.reviewList.length - 1) {
        _currentIndex++;
        currentreview = reviews[_currentIndex].review;
       SemanticsService.announce(currentreview, TextDirection.ltr);

      } else {
        _currentIndex = 0; 
                currentreview = reviews[_currentIndex].review;
// 리스트의 마지막에 도달하면 다시 처음으로
                                            SemanticsService.announce(currentreview, TextDirection.ltr);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        color: Colors.white,
        child: Semantics(
          label: '리뷰 보기',
          hint: "탭하면 다음 리뷰로 넘어갈 수 있어요.",
          
          child: InkWell(
            onTap: _nextReview, // 탭하면 다음 리뷰로 이동
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: TEXTFIELD_COLOR,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.person, color: BLACK_COLOR),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.reviewList.reviewList[_currentIndex].name,
                              style: const TextStyle(color: BLACK_COLOR),
                            ),
                          ],
                        ),
                        const SizedBox(width: 24.0),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Semantics(
                                  onTap: () {
                                    _nextReview;
                                  }
,
                                  child: Text(
                                    widget.reviewList.reviewList[_currentIndex].review,
                                    style: const TextStyle(color: BLACK_COLOR),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
