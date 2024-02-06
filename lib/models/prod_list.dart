import 'dart:convert';

class ProdList {
  List<Prod> prods;

  ProdList({
    required this.prods,
  });

  factory ProdList.fromJson(Map<String, dynamic> json) {
    List<dynamic> prodsJson = json['prods'];
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
  String dimm;
  String ratingNum;
  String link;

  Prod({
    required this.name,
    required this.price,
    required this.dimm,
    required this.ratingNum,
    required this.link,
  });

  factory Prod.fromJson(Map<String, dynamic> json) {
    return Prod(
      name: json['name'],
      price: json['price'],
      dimm: json['dimm'] ?? "",
      ratingNum: json['rating_num'] ?? '0',
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'dimm': dimm,
      'rating_num': ratingNum,
      'link': link,
    };
  }
}
