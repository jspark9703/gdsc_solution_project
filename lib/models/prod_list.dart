// Prod 모델
class Prod {
  String link;
  String name;
  String price;
  String dimm;
  String ratingNum;

  Prod({
    required this.link,
    required this.name,
    required this.price,
    required this.dimm,
    required this.ratingNum,
  });

  // JSON에서 Prod 객체로 변환하는 팩토리 생성자
  factory Prod.fromJson(Map<String, dynamic> json) => Prod(
        link: json['link'],
        name: json['name'],
        price: json['price'],
        dimm: json['dimm'],
        ratingNum: json['rating_num'],
      );

  // Prod 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'link': link,
        'name': name,
        'price': price,
        'dimm': dimm,
        'rating_num': ratingNum,
      };
}

// ProdList 모델
class ProdList {
  List<Prod> prods;

  ProdList({required this.prods});

  // JSON에서 ProdList 객체로 변환하는 팩토리 생성자
  factory ProdList.fromJson(Map<String, dynamic> json) => ProdList(
        prods: List<Prod>.from(json['prods'].map((x) => Prod.fromJson(x))),
      );

  // ProdList 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'prods': List<dynamic>.from(prods.map((x) => x.toJson())),
      };
}
