import 'package:ecommerce/service/services.dart';
import 'package:get/get.dart';
class feedback_controller extends GetxController{
  static Future<void> feedback({
    required String description,
    required String imagePath,
  }) async {
    try {
      await services.feedback(
        description: description,
        imagePath: imagePath,
      );
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}