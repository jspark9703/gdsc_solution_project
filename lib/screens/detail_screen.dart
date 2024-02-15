import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/apis/openapis.dart';
import 'package:gdsc_solution_project/commons/components/review_card.dart';
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
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({this.prod, this.isliked, super.key});

  final Prod? prod;
  final bool? isliked;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isReviewVisible = false;
  late bool _isLiked;
  String uid = AuthController().getCurrentUser();
  ReviewList reviews = ReviewList(reviewList: []);
  ProductDetail? _product; 
  ReviewList? _reviews; // 리뷰 정보를 저장할 변 수
  late bool _isImageVisible = true;
  User? currentUser;
  String? _userInfo;
  ReviewSum? _reviewSum;
  String? _description; // 상품 상세 정보를 저장할 변수

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLiked = widget.isliked ?? false;
    fetchProductDetail(); // 상품 상세 정보를 불러오는 메서드 호출
    //fetchReviews(); // 리뷰 정보를 불러오는 메서드 호출
    fetchUserClassInfo().then((value) {
      fetchReviews().then((_) {
        fetchReviewSum(_userInfo ?? '', _description ?? '', _reviews!);
      });
    });
  }

  void fetchProductDetail() async {
    final product = await ApiService().prodDetail(widget.prod!.link);
    late final String des;
    for (var i in product.details) {
      if (i.itemCate == "알레르기정보") {
        des = i.itemCate;
      }
    }
    setState(() {
      _product = product;
      _description = des; // 상품 상세 정보를 상태 변수에 저장
    });
  }

  Future<void> fetchReviews() async {
    final reviewList = await ApiService().prodReviews(widget.prod!.link);
    setState(() {
      _reviews = reviewList; // 리뷰 정보를 상태 변수에 저장
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
      _userInfo = userInfo;
    });
  }

  void fetchReviewSum(String userInfo, String des, ReviewList reviews) async {
    final ReviewSum reviewSum =
        await ApiService().prodReviewSum(userInfo, des, reviews);
    setState(() {
      _reviewSum = reviewSum;
    });
  }

  @override
  Widget build(BuildContext context) {
    Uri url0 = Uri.parse(widget.prod!.link);

    Future<void> localLaunchUrl() async {
      if (!await launchUrl(url0)) {
        throw Exception('Could not launch $url0');
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("상세정보")),
      body: _product == null
          ? const Center(
              child: Text(
                "상세정보가 준비중입니다. 잠시만 기다려주세요.",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: _isImageVisible,
                        child: Semantics(
                          image: true,
                          label: "상품 이미지",
                          child: Container(
                            child: Image.network(_product!.prodImgUrl,
                                fit: BoxFit.cover),
                          ),
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
                                Flexible(
                                  flex: 1,
                                  child: Semantics(
                                    label: "상품명",
                                    readOnly: true,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _product!.title,
                                          style: const TextStyle(
                                            color: BLACK_COLOR,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          _product!.subTitle,
                                          style: const TextStyle(
                                            color: DETAIL_COLOR,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Semantics(
                                  button: true,
                                  value: "좋아요 버튼",
                                  child: IconButton(
                                    onPressed: () {
                                      final String url = widget.prod!.link;
                                      Uri uri = Uri.parse(url);
                                      String prodId = uri.pathSegments.last;
                                      if (_isLiked) {
                                        DBService().deleteLike(uid, prodId);
                                      } else {
                                        DBService()
                                            .setLike(uid, widget.prod!, prodId);
                                      }
                                      setState(() {
                                        _isLiked = !_isLiked;
                                      });
                                    },
                                    icon: _isLiked
                                        ? const Icon(Icons.favorite)
                                        : const Icon(Icons
                                            .favorite_outline), // 아이콘은 일단 기본 아이콘으로 설정하였습니다.
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Semantics(
                              readOnly: true,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '가격',
                                    style: TextStyle(
                                      color: BLACK_COLOR,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (_product!.dimmPrice != '') ...[
                                        Text(_product!.dimmPrice,
                                            style: const TextStyle(
                                                decoration: TextDecoration
                                                    .lineThrough)),
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
                                                      ? '$part%'
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
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: BLACK_COLOR,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            const Text(
                              '주요정보',
                              style: TextStyle(
                                color: BLACK_COLOR,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Semantics(
                              label: "상품정보",
                              container: true,
                              currentValueLength: _product!.details.length,
                              readOnly: true,
                              child: Column(
                                  children: _product!.details.map((e) {
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              e.itemCate,
                                              style: const TextStyle(
                                                color: DETAIL_COLOR,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 24.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                e.itemName,
                                                style: const TextStyle(
                                                  color: DETAIL_COLOR,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                softWrap: true,
                                              ),
                                              if (e.itemContent != '')
                                                Text(
                                                  e.itemContent,
                                                  style: const TextStyle(
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
                                    const Divider(),
                                  ],
                                );
                              }).toList()),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _reviewSum == null
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: !_isReviewVisible,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '종합 리뷰',
                                      style: TextStyle(
                                        color: BLACK_COLOR,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _reviewSum!.finalOpinion,
                                      style: const TextStyle(
                                        color: GRAY_COLOR,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Text(
                                      '장점',
                                      style: TextStyle(
                                        color: BLACK_COLOR,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _reviewSum!.pros,
                                      style: const TextStyle(
                                        color: GRAY_COLOR,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Text(
                                      '단점',
                                      style: TextStyle(
                                        color: BLACK_COLOR,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _reviewSum!.cons,
                                      style: const TextStyle(
                                        color: GRAY_COLOR,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _isReviewVisible,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      '리뷰',
                                      style: TextStyle(
                                        color: BLACK_COLOR,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '${widget.prod!.ratingNum}개 리뷰 중 베스트 댓글 15개',
                                      style: const TextStyle(
                                        color: DETAIL_COLOR,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    ReviewCard(reviewList: _reviews!),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  CustomButton(
                                    onPressed: () {
                                      setState(() {
                                        _isReviewVisible =
                                            !_isReviewVisible; // 상태 업데이트
                                      });
                                    },
                                    label:
                                        _isReviewVisible ? '리뷰 숨기기 ' : '리뷰 보기',
                                    backgroundColor: LIGHT_GREEN_COLOR,
                                    textColor: GREEN_COLOR,
                                  ),
                                ],
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
                        const SizedBox(
                          height: 12.0,
                        ),
                        CustomButton(
                          onPressed: localLaunchUrl,
                          label: '사이트 확인하기',
                          backgroundColor: GREEN_COLOR,
                          textColor: Colors.white,
                        ),
                        const SizedBox(
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
