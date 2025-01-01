class Categorymodel{
  final int id;
  final String title;
  final String image;
  Categorymodel({
    required this.id,
    required this.title,
    required this.image
  });
  factory Categorymodel.fromJson(Map<String, dynamic> json) {
    return Categorymodel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}