import 'package:dio/dio.dart';
import "dart:convert";
import 'package:gdsc_solution_project/models/filter_list.dart';
import 'package:gdsc_solution_project/models/prod_detail.dart';
import 'package:gdsc_solution_project/models/prod_list.dart';
import 'package:gdsc_solution_project/models/review_list.dart';
import 'package:gdsc_solution_project/models/review_sum.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://shopping-guide-dog-final.du.r.appspot.com'; // 실제 API의 기본 URL로 변경하세요

  // 'best_filter' 엔드포인트 호출
  Future<FilterList> getBestFilters() async {
    try {
      final response = await _dio.get('$_baseUrl/best_filter');

      final data = FilterList.fromJson(response.data["data"]);
      return data;
    } catch (e) {
      throw Exception('Failed to load best filters: $e');
    }
  }

  // 'search_prod' 엔드포인트 호출
  Future<ProdList> searchProd(String? kwds, String? isBestUrl) async {
    try {
      final response = await _dio.get('$_baseUrl/search_prod',
          queryParameters: {'kwds': kwds, 'is_best_url': isBestUrl});

      final data = ProdList.fromJson(response.data["data"]);

      return data;
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

//TODO url로 수정
  // 'prod_detail' 엔드포인트 호출
  Future<ProductDetail> prodDetail(String prodUrl) async {
    try {
      final response = await _dio.get('$_baseUrl/prod_detail',
          options: Options(headers: {"Origin": _baseUrl}),
          queryParameters: {"produrl": prodUrl});
      return ProductDetail.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get product detail: $e');
    }
  }

  // 'prod_reviews' 엔드포인트 호출
  Future<ReviewList> prodReviews(String url) async {
    try {
      final response = await _dio
          .get('$_baseUrl/prod_reviews', queryParameters: {"url": url});
      print(ReviewList.fromJson(response.data['data']));
      return ReviewList.fromJson(response.data["data"]);
    } catch (e) {
      throw Exception('Failed to get product reviews: $e');
    }
  }

  Future<ReviewSum> prodReviewSum(String userInfo, ReviewList reviewList) async {
  try {
    final response = await _dio.post(
      '$_baseUrl/review_sum',
      queryParameters: {
        "user_info": userInfo,
      },
      data: reviewList.toJson(), // `review_list`를 요청 본문으로 전송
    );
    return ReviewSum.fromJson(jsonDecode(response.data["data"]) ); // 적절한 모델로 변환하세요.
  } catch (e) {
    throw Exception('Failed to get review summary: $e');
  }
}
}
