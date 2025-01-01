class user_model{
  final int id;
  late final String username;
  final String? phone;
  final String email;
  final String? address;
  final String? image;
  user_model({
    required this.id,
    required this.username,
    this.phone,
    required this.email,
    this.address,
    this.image,
  });
  factory user_model.fromjson(Map<String,dynamic>json){
    return user_model(
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      image: json['image'],
    );
  }
}