import 'package:dio/dio.dart';
import 'package:gdsc_solution_project/models/filter_list.dart';
import 'package:gdsc_solution_project/models/prod_detail.dart';
import 'package:gdsc_solution_project/models/prod_list.dart';
import 'package:gdsc_solution_project/models/review_list.dart';
import 'package:gdsc_solution_project/models/user_url.dart';
import 'package:logger/logger.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://127.0.0.1:8000'; // 실제 API의 기본 URL로 변경하세요

  // 'best_filter' 엔드포인트 호출
  Future<FilterList> getBestFilters() async {
    try {
      final response = await _dio.get('$_baseUrl/best_filter');

      final data=  FilterList.fromJson(response.data["data"]);
      return data;
    } catch (e) {

      throw Exception('Failed to load best filters: $e');
    }
  }

  // 'search_prod' 엔드포인트 호출
  Future<ProdList> searchProd(String? kwds, String? isBestUrl) async {
    try {
      final response = await _dio.get('$_baseUrl/search_prod', queryParameters: {'kwds': kwds, 'is_best_url': isBestUrl});

      final data=  ProdList.fromJson(response.data["data"]);
      return data;
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  // 'prod_detail' 엔드포인트 호출
  Future<ProductDetail> prodDetail(UserUrl userProdUrl) async {
    try {
      final response = await _dio.get('$_baseUrl/prod_detail',options: Options(headers: {"Origin":_baseUrl}), queryParameters: userProdUrl.toJson());
      return ProductDetail.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get product detail: $e');
    }
  }

  // 'prod_reviews' 엔드포인트 호출
  Future<ReviewList> prodReviews(UserUrl userUrl) async {
    try {
      final response = await _dio.get('$_baseUrl/prod_reviews', queryParameters: userUrl.toJson());
      return ReviewList.fromJson(response.data["data"]);
    } catch (e) {
      throw Exception('Failed to get product reviews: $e');
    }
  }

  // 'review_sum' 엔드포인트 호출
  Future<dynamic> prodReviewSum(UserUrl userUrl, ReviewList reviewList) async {
    // 이 메소드는 반환 타입이 프로젝트에 따라 다를 수 있으므로 예제에서는 구체적인 모델 변환을 생략합니다.
    // 적절한 반환 타입과 JSON 파싱 로직을 추가하세요.
    try {
      final response = await _dio.get('$_baseUrl/review_sum', queryParameters: {
        ...userUrl.toJson(),
        ...{'review_list': reviewList.toJson()} // 이 부분은 API와 정확히 일치하는지 확인해야 합니다.
      });
      return response.data["data"]; // 적절한 모델로 변환하세요.
    } catch (e) {
      throw Exception('Failed to get review summary: $e');
    }
  }
}
