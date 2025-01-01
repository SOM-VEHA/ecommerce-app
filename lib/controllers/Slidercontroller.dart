import 'package:ecommerce/service/services.dart';
import 'package:get/get.dart';
import 'package:ecommerce/models/Slidermodel.dart';
import 'package:get/state_manager.dart';
class Slidercontroller extends GetxController{
  var currentIndex = 0;
  var slider=<Slidermodel>[].obs;
  var loading=true.obs;
  @override
  void onInit() {
    fetchSliders();
    super.onInit();
  }
  void fetchSliders() async {
    try {
      loading.value=true;
      var sliderlist = await services.fetchSlider();
      slider.value = sliderlist.map((data) => Slidermodel.fromjson(data)).toList();
      loading.value=false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}