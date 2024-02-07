import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/components/rating_star.dart';
import 'package:gdsc_solution_project/commons/components/review_card.dart';
import 'package:gdsc_solution_project/commons/components/text_contents.dart';
import 'package:gdsc_solution_project/commons/components/text_title_box.dart';
import 'package:gdsc_solution_project/commons/navigation_bar.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/commons/components/custom_button.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/models/prod_detail.dart';
import 'package:gdsc_solution_project/models/prod_list.dart';
import 'package:gdsc_solution_project/models/review_list.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:logger/logger.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.prod, this.isliked, super.key});

  Prod? prod;
  bool? isliked;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isDetailVisible = false;
  late bool _isLiked;
  String uid = AuthController().getCurrentUser();
  ReviewList reviews = ReviewList(reviewList: []);
  ProductDetail? _product; // 상품 상세 정보를 저장할 변수
  ReviewList? _reviews; // 리뷰 정보를 저장할 변수
  @override
  void initState() {
    super.initState();
    _isLiked = widget.isliked ?? false;

    fetchProductDetail(); // 상품 상세 정보를 불러오는 메서드 호출
    fetchReviews(); // 리뷰 정보를 불러오는 메서드 호출
  }

  void fetchProductDetail() async {
    final product = await ApiService().prodDetail(widget.prod!.link);
    setState(() {
      _product = product; // 상품 상세 정보를 상태 변수에 저장
    });
  }

  void fetchReviews() async {
    final reviewList = await ApiService().prodReviews(widget.prod!.link);
    setState(() {
      _reviews = reviewList; // 리뷰 정보를 상태 변수에 저장
    });
  }

  @override
  void dispose() {
    final String url = widget.prod!.link;
    Uri uri = Uri.parse(url);
    String _prodId = uri.pathSegments.last;
    if (!_isLiked) {
      DBService().deleteLike(uid, _prodId);
    } else {
      DBService().setLike(uid, widget.prod!, _prodId);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String url = widget.prod!.link;
    Uri uri = Uri.parse(url);
    String _ProdId = uri.pathSegments.last;

    return _product == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(),

            //TODO futurebuilder이용해서 디테일 정보 받아오기
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Image.network(_product!.prodImgUrl,
                            fit: BoxFit.cover),
                      ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _product!.title,
                                      style: const TextStyle(
                                        color: BLACK_COLOR,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      _product!.subTitle,
                                      style: TextStyle(
                                        color: DETAIL_COLOR,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 0.10,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLiked = !_isLiked;
                                    });
                                  },
                                  tooltip: "좋아요",
                                  icon: _isLiked
                                      ? Icon(Icons.favorite)
                                      : Icon(Icons
                                          .favorite_outline), // 아이콘은 일단 기본 아이콘으로 설정하였습니다.
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '가격',
                                  style: TextStyle(
                                    color: BLACK_COLOR,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Column(
                                  children: [
                                    if (_product!.dimmPrice != '') ...[
                                      Text(_product!.dimmPrice,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ..._product!.price
                                              .split('%')
                                              .map((part) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text(
                                                part ==
                                                        _product!.price
                                                            .split('%')
                                                            .first
                                                    ? part + '%'
                                                    : part,
                                                style: TextStyle(
                                                  fontSize: part ==
                                                          _product!.price
                                                              .split('%')
                                                              .first
                                                      ? 18
                                                      : 20,
                                                  color: part ==
                                                          _product!.price
                                                              .split('%')
                                                              .first
                                                      ? Colors.red
                                                      : BLACK_COLOR,
                                                  fontWeight: part ==
                                                          _product!.price
                                                              .split('%')
                                                              .first
                                                      ? FontWeight.w400
                                                      : FontWeight.w700,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    ] else ...[
                                      Text(
                                        _product!.price,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: BLACK_COLOR,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              '주요정보',
                              style: TextStyle(
                                color: BLACK_COLOR,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Column(
                                children: _product!.details.map((e) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            e.itemCate,
                                            style: TextStyle(
                                              color: DETAIL_COLOR,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 24.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              e.itemName,
                                              style: TextStyle(
                                                color: DETAIL_COLOR,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            if (e.itemContent != '')
                                              Text(
                                                e.itemContent,
                                                style: TextStyle(
                                                  color: DETAIL_COLOR,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            }).toList()),
                            SizedBox(
                              height: 12.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _reviews == null
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '리뷰',
                                style: TextStyle(
                                  color: BLACK_COLOR,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${widget.prod!.ratingNum}개의 리뷰',
                                style: TextStyle(
                                  color: DETAIL_COLOR,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              //TODO futurebuilder이용해서 리뷰 정보, 리뷰 요약 받아오기

                              TextTitleBox(
                                mainText: '종합 리뷰',
                                mode: 'sub',
                              ),
                              TextContentBox(
                                mainText: _reviews!.reviewList.first.review,
                              ),
                              Visibility(
                                visible: _isDetailVisible,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextTitleBox(
                                      mainText: '장점',
                                      mode: 'sub',
                                    ),
                                    TextContentBox(
                                      mainText: '맛과 식감: 사용자는 제품의 맛을 극찬하며, ...',
                                    ),
                                    TextTitleBox(
                                      mainText: '단점',
                                      mode: 'sub',
                                    ),
                                    TextContentBox(
                                      mainText:
                                          '수입산 고기 사용: 몇몇 리뷰어들은 수입산 고기를 사용한 것이 아쉽다고 언급했으나...',
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  CustomButton(
                                    onPressed: () {
                                      setState(() {
                                        _isDetailVisible =
                                            !_isDetailVisible; // 상태 업데이트
                                      });
                                    },
                                    label: _isDetailVisible
                                        ? '리뷰 요약보기'
                                        : '리뷰 자세히 보기',
                                    backgroundColor: LIGHT_GREEN_COLOR,
                                    textColor: GREEN_COLOR,
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  CustomButton(
                                    onPressed: () {},
                                    label: '사이트 확인하기',
                                    backgroundColor: GREEN_COLOR,
                                    textColor: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            bottomNavigationBar: AppNavigationBar(currentIndex: 1),
          );
  }
}
