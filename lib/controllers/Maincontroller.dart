import 'package:ecommerce/views/Cartpage.dart';
import 'package:ecommerce/views/Favoritepage.dart';
import 'package:ecommerce/views/Homepage.dart';
import 'package:ecommerce/views/Settingpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class Maincontroll extends GetxController{
  int Index=0;
  List Page=[
    Homepage(),
    Cartspage(),
    Favoritepage(),
    Settingspage(),
    // Container(),
    // Container(),
    // Container(),
  ];
}