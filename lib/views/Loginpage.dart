import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Authcontroller.dart';
import 'package:ecommerce/views/Registerpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final controller = Authcontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //email
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
            child: TextField(
              controller: controller.email,
              decoration: InputDecoration(
                label: Text('Email'.tr),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                fillColor: kcontentColor,
                filled: true,
              ),
            ),
          ),
          //password
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: TextField(
              obscureText: controller.isHidden,
              controller: controller.password,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                label: Text('Password'.tr),
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      controller.isHidden
                          ? controller.isHidden = false
                          : controller.isHidden = true;
                    });
                  },
                  child: controller.isHidden
                      ? const Icon(Icons.visibility)
                      : const Icon(
                          Icons.visibility_off_outlined,
                        ),
                ),
              ),
            ),
          ),
          //forgot password
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "forgot Password ? ".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          //button
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: MaterialButton(
              onPressed: () {
                controller.userlogin();
              },
              color: buttonColor,
              textColor: Colors.white,
              minWidth: double.infinity,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Obx(
                    () => controller.loading.value
                    ? Container(
                  height: 20,
                  width: 20,
                  child: const CircularProgressIndicator(),
                )
                    : Text(
                  'Login'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          // Don't have account
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account ? ".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(Registerpage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Sign up'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
