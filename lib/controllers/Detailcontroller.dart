import 'dart:convert';
import 'package:ecommerce/api/api.dart';
import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/models/Productmodel.dart';
import 'package:ecommerce/service/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class Detaicontroller extends GetxController{
  var details = <Productmodel>[].obs;
  var isloading=true.obs;
  var currentIndex = 0;
  void fetchDetail(String id) async {
    try {
      isloading.value=true;
      var sliderlist = await services.fetchDetail(id);
      details.value = sliderlist.map((data) => Productmodel.fromJson(data)).toList();
      isloading.value=false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}