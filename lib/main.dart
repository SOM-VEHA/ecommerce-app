import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/views/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/views/Splashpage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/translations_controller.dart';
main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Tokencontroller.getlanguages()==null?Locale("US"):Locale(Tokencontroller.getlanguages().toString()),
      translations: translations_controller(),
      home:Splashpage(),
    );
  }
}
