import 'package:ecommerce/controllers/Imagemodel.dart';

class Productmodel{
  final int id;
  final String title;
  final String description;
  final double price;
  final int ? is_favorite;
  final List<Imagemodel> images;
  Productmodel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.is_favorite,
  });
  factory Productmodel.fromJson(Map<String, dynamic> json) {
    return Productmodel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      is_favorite: json['is_favorite'],
      images: (json['image'] as List).map((image) => Imagemodel.fromjson(image)).toList(),
    );
  }
}