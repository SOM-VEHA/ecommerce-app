class Imagemodel{
  final int id;
  final String image;
  final int product_id;
  Imagemodel({
    required this.id,
    required this.image,
    required this.product_id,
  });
  factory Imagemodel.fromjson(Map<String,dynamic>json){
    return Imagemodel(
      id:json['id'],
      image:json['image'],
      product_id:json['product_id'],
    );
  }
}