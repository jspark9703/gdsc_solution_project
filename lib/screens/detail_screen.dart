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
import 'package:gdsc_solution_project/models/review_sum.dart';
import 'package:gdsc_solution_project/models/user_url.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/provider/user_info_provider.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.prod, this.isliked, super.key});

  final Prod? prod;
  final bool? isliked;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isDetailVisible = false;
  late bool _isLiked;
  String uid = AuthController().getCurrentUser();
  ReviewList reviews = ReviewList(reviewList: []);
  ProductDetail? _product; // 상품 상세 정보를 저장할 변수
  ReviewList? _reviews; // 리뷰 정보를 저장할 변 수
  late bool _isImageVisible;
  User? currentUser;
  String? _userInfo;
  ReviewSum? _reviewSum;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLiked = widget.isliked ?? false;

    fetchProductDetail(); // 상품 상세 정보를 불러오는 메서드 호출
    //fetchReviews(); // 리뷰 정보를 불러오는 메서드 호출
    fetchUserClassInfo().then((value) {
      fetchReviews().then((_) {
        fetchReviewSum(_userInfo ?? '', _reviews!);
      });
    });
  }

  void fetchProductDetail() async {
    final product = await ApiService().prodDetail(widget.prod!.link);
    setState(() {
      _product = product; // 상품 상세 정보를 상태 변수에 저장
    });
  }

  Future<void> fetchReviews() async {
    final reviewList = await ApiService().prodReviews(widget.prod!.link);
    setState(() {
      _reviews = reviewList; // 리뷰 정보를 상태 변수에 저장
      print(_reviews!.reviewList.length);

      fetchReviewSum(_userInfo ?? '', _reviews!);
    });
  }

  Future<void> fetchUserClassInfo() async {
    dynamic userClass = Get.find<UserInfoController>().user.value!.userClass;
    dynamic userInfo = Get.find<UserInfoController>().user.value!.userInfo;
    setState(() {
      if (userClass == '1등급' || userClass == '2등급') {
        _isImageVisible = false;
      } else {
        _isImageVisible = true;
      }
      ;
      _userInfo = userInfo;
    });
  }

  void fetchReviewSum(String userInfo, ReviewList reviews) async {
    final ReviewSum reviewSum =
        await ApiService().prodReviewSum(userInfo, reviews);
    setState(() {
      _reviewSum = reviewSum;
    });
    print(reviewSum);
  }

  @override
  Widget build(BuildContext context) {
    Uri _url = Uri.parse(widget.prod!.link);

    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }
    return _product == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(title: Text("상세정보")),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: _isImageVisible,
                        child: Container(
                          child: Image.network(_product!.prodImgUrl,
                              fit: BoxFit.cover),
                        ),
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
                                    final String url = widget.prod!.link;
                                    Uri uri = Uri.parse(url);
                                    String _prodId = uri.pathSegments.last;
                                    if (_isLiked) {
                                      DBService().deleteLike(uid, _prodId);
                                    } else {
                                      DBService()
                                          .setLike(uid, widget.prod!, _prodId);
                                    }
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
                              SizedBox(height: 16.0),
                              ReviewCard(reviewList: _reviews!),
                            ],
                          ),
                        ),
                  _reviewSum == null
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '종합 리뷰',
                                style: TextStyle(
                                  color: BLACK_COLOR,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                _reviewSum!.finalOpinion,
                                style: TextStyle(
                                  color: GRAY_COLOR,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Visibility(
                                visible: _isDetailVisible,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '장점',
                                      style: TextStyle(
                                        color: BLACK_COLOR,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _reviewSum!.pros,
                                      style: TextStyle(
                                        color: GRAY_COLOR,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '단점',
                                      style: TextStyle(
                                        color: BLACK_COLOR,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _reviewSum!.cons,
                                      style: TextStyle(
                                        color: GRAY_COLOR,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 12.0,
                        ),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              _isDetailVisible = !_isDetailVisible; // 상태 업데이트
                            });
                          },
                          label: _isDetailVisible ? '리뷰 요약보기' : '리뷰 자세히 보기',
                          backgroundColor: LIGHT_GREEN_COLOR,
                          textColor: GREEN_COLOR,
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        CustomButton(
                          onPressed: _launchUrl,
                          label: '사이트 확인하기',
                          backgroundColor: GREEN_COLOR,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: 12.0,
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
