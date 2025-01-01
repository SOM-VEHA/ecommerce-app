import 'package:ecommerce/models/Cartmodel.dart';
import 'package:ecommerce/service/services.dart';
import 'package:get/get.dart';
class Cartcontroller extends GetxController{
  var carts = <Cartsmodel>[].obs;
  var loading=true.obs;
  @override
  void onInit() {
    fetchCarts();
    super.onInit();
  }
  void fetchCarts() async {
    try {
      loading.value=true;
      var cartslist = await services.fetchCarts();
      carts.value = cartslist.map((data) => Cartsmodel.fromjson(data)).toList();
      loading.value=false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  void removeCarts(String id) async {
    try {
      await services.removeCarts(id);
      fetchCarts();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  void addCarts(int id,int qty)async{
    try {
      await services.addCarts(id,qty);
      fetchCarts();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  void addCounter(int id,int qty)async{
    try {
      await services.addConter(id,qty);
      fetchCarts();
    } catch (e) {
      print(e);
    }
  }
  double get totalPrice => carts.fold(0.0, (sum, item) => sum + item.totalprice);
}