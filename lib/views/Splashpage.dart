import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/views/Loginpage.dart';
import 'package:ecommerce/views/Mainpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class Splashpage extends StatefulWidget {
  Splashpage({super.key});
  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5), () {
        return Get.offAll(Tokencontroller.getToken() == null ? Loginpage() : Mainpage());
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          height: 200,
          width: 200,
          image: AssetImage('assets/image/otpimage.jpg'),
        ),
      ),
    );
  }
}
