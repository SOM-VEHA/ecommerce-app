class Subcategorymodel{
  final int id;
  final String title;
  final String image;
  final int categories_id;
  Subcategorymodel({
    required this.id,
    required this.title,
    required this.image,
    required this.categories_id
  });
  factory Subcategorymodel.fromJson(Map<String, dynamic> json) {
    return Subcategorymodel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      categories_id: json['categories_id'],
    );
  }
}