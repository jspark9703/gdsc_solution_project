// Review 모델
class Review {
  String name;
  String? url; // 선택적 필드, null 허용
  String review;

  Review({
    required this.name,
    this.url, // 필수가 아닌 선택적 필드
    required this.review,
  });

  // JSON에서 Review 객체로 변환하는 팩토리 생성자
  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json['name'],
        url: json['url'] as String?, // null 허용 필드 처리
        review: json['review'],
      );

  // Review 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url, // null 허용 필드 처리
        'review': review,
      };
}

// ReviewList 모델
class ReviewList {
  List<Review> reviewList;

  ReviewList({required this.reviewList});

  // JSON에서 ReviewList 객체로 변환하는 팩토리 생성자
  factory ReviewList.fromJson(Map<String, dynamic> json) => ReviewList(
        reviewList: List<Review>.from(json['review_list'].map((x) => Review.fromJson(x))),
      );

  // ReviewList 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'review_list': List<dynamic>.from(reviewList.map((x) => x.toJson())),
      };
}
