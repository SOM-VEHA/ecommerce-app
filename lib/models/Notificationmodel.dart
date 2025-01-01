import 'package:ecommerce/models/Productmodel.dart';

class Notificationmodel{
  final int id;
  final int product_id;
  Productmodel product;
  Notificationmodel({
    required this.id,
    required this.product_id,
    required this.product,
  });
  factory Notificationmodel.fromJson(Map<String, dynamic> json) {
    return Notificationmodel(
      id: json['id'],
      product_id: json['product_id'],
      product: Productmodel.fromJson(json['product']),
    );
  }
}