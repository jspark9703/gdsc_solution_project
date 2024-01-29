import 'dart:convert';

class ProdList {
  List<Prod> prods;

  ProdList({
    required this.prods,
  });

  factory ProdList.fromJson(String jsonString) {
    List<dynamic> prodsJson = json.decode(jsonString)['prods'];
    List<Prod> prods = prodsJson.map((prodJson) {
      return Prod.fromJson(prodJson);
    }).toList();

    return ProdList(prods: prods);
  }

  String toJson() {
    List<Map<String, dynamic>> prodsJson =
        prods.map((prod) => prod.toJson()).toList();

    return json.encode({'prods': prodsJson});
  }
}

class Prod {
  String name;
  String price;
  String couponPrice;
  int rating;
  int ratingNum;
  String link;

  Prod({
    required this.name,
    required this.price,
    required this.couponPrice,
    required this.rating,
    required this.ratingNum,
    required this.link,
  });

  factory Prod.fromJson(Map<String, dynamic> json) {
    return Prod(
      name: json['name'].toString(),
      price: json['price'].toString(),
      couponPrice: json['coupon_price'].toString(),
      rating: json['rating'] as int,
      ratingNum: json['rating_num'] as int,
      link: json['link'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'coupon_price': couponPrice,
      'rating': rating,
      'rating_num': ratingNum,
      'link': link,
    };
  }
}
