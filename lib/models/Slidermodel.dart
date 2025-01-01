class Slidermodel{
  final int id;
  final String image;
  final String title;
  Slidermodel({required this.id,required this.image,required this.title});
  factory Slidermodel.fromjson(Map<String,dynamic>json){
    return Slidermodel(
      id:json['id'],
      image:json['image'],
      title: json['title'],
    );
  }
}