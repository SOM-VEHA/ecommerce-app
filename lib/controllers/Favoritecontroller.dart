import 'package:ecommerce/controllers/Productcontroller.dart';
import 'package:ecommerce/models/Favoritemodel.dart';
import 'package:ecommerce/service/services.dart';
import 'package:get/get.dart';
class Favoritecontroller extends GetxController {
  final productcontroller = Get.put(Productcontroller());
  var favorites = <Favoritemodel>[].obs;
  var isloading = true.obs;
  @override
  void onInit() {
    fetchFavorite();
    super.onInit();
  }

  void fetchFavorite() async {
    try {
      isloading.value = true;
      var cartslist = await services.fetchFavorite();
      favorites.value = cartslist.map((data) => Favoritemodel.fromJson(data)).toList();
      isloading.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  void remove_add(String id) async {
    try {
      await services.addFavorite(id);
      fetchFavorite();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
