import 'package:ecommerce/views/Loginpage.dart';
import 'package:ecommerce/views/Splashpage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Tokencontroller{
  static final box = GetStorage();
  static String? getToken() {
    return box.read('token');
  }
  static String? getlanguages(){
    return box.read("languages");
  }
  void setToken(String token) {
    box.write('token', token);
  }
  void setlanguages(String languages){
    box.write('languages', languages);
  }
  void clearToken(){
    box.remove("token");
    Get.offAll(Loginpage());
  }
}