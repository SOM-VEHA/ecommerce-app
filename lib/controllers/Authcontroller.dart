import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/service/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Authcontroller extends GetxController {

  var loading = false.obs;

  bool isHidden = true;

  final token=Tokencontroller();

  final username=TextEditingController();

  final email = TextEditingController();

  final password=TextEditingController();

  final confirm=TextEditingController();

  void userlogin()async{
    try {
      if(email.text.isEmpty&&password.text.isEmpty){
        Get.snackbar("Error", "Email and Password is Not Empty..",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }else if(email.text.isEmpty&&password.text.isNotEmpty){
        Get.snackbar("Error", "Email  is Not Empty..",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }else if(email.text.isNotEmpty&&password.text.isEmpty){
        Get.snackbar("Error", "Password is Not Empty..",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }else{
        loading.value=true;
        await services.userlogin(email.text,password.text);
        clear();
        loading.value=false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void userRegister()async{
    try {
      if(username.text.isEmpty&&email.text.isEmpty&&password.text.isEmpty){
        Get.snackbar("Error", "Email and Password is Not Empty..",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }else if(username.text.isNotEmpty&&password.text.isEmpty&&email.text.isEmpty){
        Get.snackbar("Error", "Email  is Not Empty..",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }else if(username.text.isEmpty&&password.text.isEmpty&&email.text.isNotEmpty){
        Get.snackbar("Error", "Password is Not Empty..",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }else if(username.text.isEmpty&&password.text.isNotEmpty&&email.text.isEmpty){
        Get.snackbar("Error", "Password is Not Empty..",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }else{
        loading.value=true;
        await services.userRegister(username.text,email.text,password.text);
        clear();
        loading.value=false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void logout() {
    Get.defaultDialog(
      title: '',
      content:  const Text("Are You want to Logout ?"),
      confirm: TextButton(
        onPressed: () {
          token.clearToken();
        },
        child: const Text("Confirm",style: TextStyle(color: Colors.red),),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("Cancel",style: (TextStyle(color: Colors.blueAccent)),),
      ),
    );
  }

  void clear(){
    email.clear();
    password.clear();
    username.clear();
    confirm.clear();
  }
}