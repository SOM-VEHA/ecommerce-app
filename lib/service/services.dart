import 'dart:convert';
import 'package:ecommerce/api/api.dart';
import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/views/Mainpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../views/Loginpage.dart';
class services {
  static Tokencontroller token=Tokencontroller();
  ///userlogin
  static Future<void> userlogin(String email,String password) async {
    final url = Uri.parse(api.login);
    final body = json.encode({"email": email,"password":password});
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == true) {
        token.setToken(json.decode(response.body)['token']);
        Get.offAll(Mainpage());
      }else{
        Get.snackbar(json.decode(response.body)['status'] == false?"Error":"Sucess", "${json.decode(response.body)['message']}",backgroundColor: Colors.redAccent,colorText: Colors.white);
        Get.to(Loginpage());
      }
    } else {
      throw Exception("Failed to toggle favorite: ${response.body}");
    }
  }
  ///userregister
  static Future<void> userRegister(String username,String email,String password) async {
    final url = Uri.parse(api.Register);
    final body = json.encode({"username":username,"email": email,"password":password});
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == true) {
        Get.back();
      }
    } else {
      throw Exception("Failed to toggle favorite: ${response.body}");
    }
  }
  ///updateUserData
  static Future<void> updateUserData({
    required String username,
    required String phone,
    required String address,
    String? imagePath,
  }) async {
    final Uri url = Uri.parse(api.updateUser);
    var headers = {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    };
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'username': username,
      'phone': phone,
      'address': address,
    });
    if (imagePath != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', imagePath),
      );
    }
    request.headers.addAll(headers);
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
    } else {
      throw Exception('Failed to update user data: ${response.reasonPhrase}');
    }
  }
  /// fetchCategory
  static Future<List<dynamic>> fetchCategory() async {
    final url = Uri.parse(api.category);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['categories'];
    } else {
      throw Exception('Failed to load Categorys');
    }
  }
  ///fetchSubCategory
  static Future<List<dynamic>> fetchSubCategory(String id) async {
    final url = Uri.parse(api.subcategory+id);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['Subcategories'];
    } else {
      throw Exception('Failed to load Subcategories');
    }
  }
  ///fetchSlider
  static Future<List<dynamic>> fetchSlider() async {
    final url = Uri.parse(api.slider);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['slider'];
    } else {
      throw Exception('Failed to load Sliders');
    }
  }
  ///fetchProduct
  static Future<List<dynamic>> fetchProduct() async {
    final url = Uri.parse(api.product);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['products'];
    } else {
      throw Exception('Failed to load Products');
    }
  }
///fetchDetail
  static Future<List<dynamic>> fetchDetail(String id) async {
    final url = Uri.parse(api.detail+id);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['products'];
    } else {
      throw Exception('Failed to load Products');
    }
  }
  /// fetchProduct_Subcategory
  static Future<List<dynamic>> fetchProduct_subcategory(int subcategory_id) async {
    final url = Uri.parse(api.product+"/${subcategory_id}");
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['products']);
      return jsonDecode(response.body)['products'];
    } else {
      throw Exception('Failed to load Products');
    }
  }
  ///fetchFavorite
  static Future<List<dynamic>> fetchFavorite() async {
    final url = Uri.parse(api.getfavorite);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['favorite'];
    } else {
      throw Exception('Failed to load favorite');
    }
  }
  /// Add to favorites and Remove from favorites
  static Future<void> addFavorite(String id) async {
    final url = Uri.parse(api.storefavorite);
    final body = json.encode({"id": id,});
    final response = await http.post(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    }, body: body);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == true) {
        Get.snackbar("Sucess", "${json.decode(response.body)['message']}",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }
    } else {
      throw Exception("Failed to toggle favorite: ${response.body}");
    }
  }
  /// fetchCarts
  static Future<List<dynamic>> fetchCarts() async {
    final url = Uri.parse(api.carts);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['cart'];
    } else {
      throw Exception('Failed to load carts');
    }
  }
  /// add to Carts
  static Future<void> addCarts(int id,int qty) async {
    final url = Uri.parse(api.addcart);
    final body = json.encode({"product_id": id,"qty":qty});
    final response = await http.post(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    }, body: body);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == true) {
        Get.snackbar("Sucess", "${json.decode(response.body)['message']}",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }
    } else {
      throw Exception("Failed to toggle favorite: ${response.body}");
    }
  }
  /// remove from Carts
  static Future<void> removeCarts(String id) async {
    final url = Uri.parse(api.cartsremove);
    final body = json.encode({"id": id,});
    final response = await http.post(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    }, body: body);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == true) {
        Get.snackbar("Sucess", "${json.decode(response.body)['message']}",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }
    } else {
      throw Exception("Failed to toggle favorite: ${response.body}");
    }
  }
  ////
  static Future<void> addConter(int id,int qty) async {
    final url = Uri.parse(api.addconter);
    final body = json.encode({"id": id,"qty":qty});
    final response = await http.post(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    }, body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to toggle favorite: ${response.body}");
    }
  }
  ///fectuser
  static Future<List<dynamic>> fetchUser() async {
    final url = Uri.parse(api.user);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['user']);
      return jsonDecode(response.body)['user'];
    } else {
      throw Exception('Failed to load carts');
    }
  }
  ///feedback
  static Future<void> feedback({
    required String description,
    required String imagePath,
  }) async {
    final Uri url = Uri.parse(api.feedback);
    var headers = {
      "Authorization": "Bearer ${Tokencontroller.getToken()}",
      "Content-Type": "application/json",
    };
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'description': description,
    });
    // Add file
    request.files.add(
      await http.MultipartFile.fromPath('image', imagePath),
    );
    request.headers.addAll(headers);
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);
      if (decodedResponse['status'] == 'success') {
        Get.snackbar(
          'Success',
          decodedResponse['message'], // Display dynamic message
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } else {
      throw Exception('Failed to update user data: ${response.reasonPhrase}');
    }
  }
  ///create order
}
