import 'dart:convert';

class ReviewList {
  List<Review> reviewList;

  ReviewList({
    required this.reviewList,
  });

  factory ReviewList.fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<dynamic> reviewsJson = jsonMap['review_list'];
    List<Review> reviews = reviewsJson.map((reviewJson) {
      return Review.fromJson(reviewJson);
    }).toList();

    return ReviewList(reviewList: reviews);
  }

  String toJson() {
    List<Map<String, dynamic>> reviewsJson =
        reviewList.map((review) => review.toJson()).toList();

    return json.encode({'review_list': reviewsJson});
  }
}

class Review {
  String rating;
  String title;
  String content;

  Review({
    required this.rating,
    required this.title,
    required this.content,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'].toString(),
      title: json['title'].toString(),
      content: json['content'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'title': title,
      'content': content,
    };
  }
}
