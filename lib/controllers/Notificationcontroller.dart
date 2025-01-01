import 'dart:async';
import 'dart:convert';
import 'package:ecommerce/api/api.dart';
import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/models/Notificationmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class NotificationController extends GetxController {
  var notification = <Notificationmodel>[].obs;
  var isLoading = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchNotification();
    startRealTimeUpdates();
  }

  Future<void> fetchNotification() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(api.notification),
        headers: {
          "Authorization": "Bearer ${Tokencontroller.getToken()}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['notification'];
        notification.assignAll(
          jsonList.map((json) => Notificationmodel.fromJson(json)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch notifications');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void startRealTimeUpdates() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      fetchNotification();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
