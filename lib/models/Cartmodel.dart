import 'package:ecommerce/models/Productmodel.dart';

class Cartsmodel {
  final int id;
  final int user_id;
  final int product_id;
  final double totalprice;
  final int qty;
  Productmodel product;
  Cartsmodel({
    required this.id,
    required this.user_id,
    required this.product_id,
    required this.product,
    required this.totalprice,
    required this.qty,
  });
  factory Cartsmodel.fromjson(Map<String, dynamic> json) {
    return Cartsmodel(
      id: json['id'],
      user_id: json['user_id'],
      product_id: json['product_id'],
      totalprice: double.parse(json['totalprice'].toString()),
      product: Productmodel.fromJson(json['product']),
      qty: json['qty'],
    );
  }
}