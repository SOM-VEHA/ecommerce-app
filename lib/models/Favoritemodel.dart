import 'package:ecommerce/models/Productmodel.dart';

class Favoritemodel {
  final int id;
  final int user_id;
  final int product_id;
  Productmodel product;
  Favoritemodel({
    required this.id,
    required this.user_id,
    required this.product_id,
    required this.product,
  });
  factory Favoritemodel.fromJson(Map<String, dynamic> json) {
    return Favoritemodel(
      id: json['id'],
      user_id: json['user_id'],
      product_id: json['product_id'],
      product: Productmodel.fromJson(json['product']),
    );
  }
}