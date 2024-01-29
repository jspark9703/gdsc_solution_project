import 'dart:convert';

class ProductDetail {
  String brand;
  String title;
  String seller;
  String prodSalePrice;
  String prodCouponPrice;
  String prodDescription;

  ProductDetail({
    required this.brand,
    required this.title,
    required this.seller,
    required this.prodSalePrice,
    required this.prodCouponPrice,
    required this.prodDescription,
  });

  factory ProductDetail.fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return ProductDetail(
      brand: jsonMap['brand'].toString(),
      title: jsonMap['title'].toString(),
      seller: jsonMap['seller'].toString(),
      prodSalePrice: jsonMap['prod_sale_price'].toString(),
      prodCouponPrice: jsonMap['prod_coupon_price'].toString(),
      prodDescription: jsonMap['prod_description'].toString(),
    );
  }

  String toJson() {
    return json.encode({
      'brand': brand,
      'title': title,
      'seller': seller,
      'prod_sale_price': prodSalePrice,
      'prod_coupon_price': prodCouponPrice,
      'prod_description': prodDescription,
    });
  }
}
