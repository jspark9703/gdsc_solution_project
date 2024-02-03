// Item 모델
class Item {
  String itemCate;
  String itemName;
  String itemContent;

  Item({
    required this.itemCate,
    required this.itemName,
    required this.itemContent,
  });

  // JSON에서 Item 객체로 변환하는 팩토리 생성자
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemCate: json['item_cate'],
        itemName: json['item_name'],
        itemContent: json['item_content'],
      );

  // Item 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'item_cate': itemCate,
        'item_name': itemName,
        'item_content': itemContent,
      };
}

// ProductDetail 모델
class ProductDetail {
  String prodImgUrl;
  String title;
  String subTitle;
  String price;
  String dimmPrice;
  String description;
  List<Item> details;

  ProductDetail({
    required this.prodImgUrl,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.dimmPrice,
    required this.description,
    required this.details,
  });

  // JSON에서 ProductDetail 객체로 변환하는 팩토리 생성자
  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        prodImgUrl: json['prod_img_url'],
        title: json['title'],
        subTitle: json['sub_title'],
        price: json['price'],
        dimmPrice: json['dimm_price'],
        description: json['description'],
        details: List<Item>.from(json['details'].map((x) => Item.fromJson(x))),
      );

  // ProductDetail 객체에서 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => {
        'prod_img_url': prodImgUrl,
        'title': title,
        'sub_title': subTitle,
        'price': price,
        'dimm_price': dimmPrice,
        'description': description,
        'details': List<dynamic>.from(details.map((x) => x.toJson())),
      };
}
