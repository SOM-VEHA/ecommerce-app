import 'package:ecommerce/controllers/Authcontroller.dart';
import 'package:ecommerce/controllers/Cartcontroller.dart';
import 'package:ecommerce/controllers/Categorycontroller.dart';
import 'package:ecommerce/controllers/Favoritecontroller.dart';
import 'package:ecommerce/controllers/Maincontroller.dart';
import 'package:ecommerce/controllers/Productcontroller.dart';
import 'package:ecommerce/controllers/Slidercontroller.dart';
import 'package:flutter/material.dart';
import 'package:cuberto_bottom_bar/internal/cuberto_bottom_bar.dart';
import 'package:cuberto_bottom_bar/internal/tab_data.dart';
import 'package:get/get.dart';
class  Mainpage extends StatefulWidget {
  Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final controller=Maincontroll();
  final user=Get.put(Authcontroller());
  final slidercontroller = Get.put(Slidercontroller());
  final categorycontroller = Get.put(Categorycontroller());
  final productcontroller = Get.put(Productcontroller());
  final favoritecontroller=Get.put(Favoritecontroller());
  final cartcontroller=Get.put(Cartcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.Page[controller.Index],
      bottomNavigationBar: CubertoBottomBar(
        selectedTab: controller.Index,
        tabs:  [
          TabData(
            iconData: Icons.home_outlined,
            title: 'Home'.tr,
            tabColor: Colors.green,
          ),
          TabData(
            iconData: Icons.shopping_cart_outlined,
            title: 'Carts'.tr,
            tabColor: Colors.green,
          ),
          TabData(
            iconData: Icons.favorite_border,
            title: 'Favorite'.tr,
            tabColor: Colors.green,
          ),
          TabData(
            iconData: Icons.settings_outlined,
            title: 'Settings'.tr,
            tabColor: Colors.green,
          ),
        ],
        onTabChangedListener: (position, title, color) {
          setState(() {
            controller.Index = position;
          });
        },
      ),
    );
  }
}
