import 'package:ecommerce/models/Categorymodel.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/service/services.dart';
import 'package:get/get.dart';
import '../models/Subcategorymodel.dart';
class Categorycontroller extends GetxController{
  var category = <Categorymodel>[].obs;
  var subcategories = <Subcategorymodel>[].obs;
  var user=<user_model>[].obs;
  var isloading=true.obs;
  @override
  void onInit() {
    fetchCategory();
    fetchUser();
    super.onInit();
  }
  ///fectCategory
  void fetchCategory() async {
    try {
      isloading.value=true;
      var categorylist = await services.fetchCategory();
      category.value = categorylist.map((data) => Categorymodel.fromJson(data)).toList();
      isloading.value=false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  ///fetchSubCategory
  void fetchSubCategory(String id) async {
    try {
      isloading.value=true;
      var subcategorylist = await services.fetchSubCategory(id);
      subcategories.value = subcategorylist.map((data) => Subcategorymodel.fromJson(data)).toList();
      isloading.value=false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  ///fetchUser
  void fetchUser() async {
    try {
      isloading.value=true;
      var user_list = await services.fetchUser();
      user.value = user_list.map((data) => user_model.fromjson(data)).toList();
      isloading.value=false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  ///updateUser
  static Future<void> updateUser({
    required String username,
    required String phone,
    required String address,
    String? imagePath,
  }) async {
    try {
      await services.updateUserData(
        username: username,
        phone: phone,
        address: address,
        imagePath: imagePath,
      );
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}