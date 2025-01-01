import 'dart:convert';
import 'package:ecommerce/api/api.dart';
import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/models/Productmodel.dart';
import 'package:ecommerce/service/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class Productcontroller extends GetxController{

  var products = <Productmodel>[].obs;

  var products_subcategory=<Productmodel>[].obs;

  var isloading=true.obs;

  var searchText = ''.obs;

  var loading=true.obs;

  @override
  void onInit() {
    Fectproduct();
    super.onInit();
  }
  void Fectproduct()async{
    try {
      isloading.value=true;
      final response = await http.get(
        Uri.parse(api.product),
        headers: {
          "Authorization": "Bearer ${Tokencontroller.getToken()}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isloading.value=false;
        final List<dynamic> jsonList = json.decode(response.body)['products'];
        products.assignAll(jsonList.map((json) => Productmodel.fromJson(json)).toList());
      } else {
        Get.snackbar('Error', 'Failed to fetch product');
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchproduct_subcategory(int subcategory_id) async {
    try {
      loading.value=true;
      var products = await services.fetchProduct_subcategory(subcategory_id);
      products_subcategory.value = products.map((data) => Productmodel.fromJson(data)).toList();
      loading.value=false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  RxList<Productmodel> get filteredProducts {
    if (searchText.value.isEmpty) {
      return products;
    } else {
      return products
          .where((product) => product.title
          .toLowerCase()
          .contains(searchText.value.toLowerCase()))
          .toList()
          .obs;
    }
  }

  updateSearchText(String text) {
    searchText.value = text;
  }
}