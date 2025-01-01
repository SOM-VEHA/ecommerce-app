import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final controller = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //username
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
            child: TextField(
              controller: controller.username,
              decoration: InputDecoration(
                label: Text('Username'.tr),
                prefixIcon: Icon(
                  Icons.person,
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
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            child: TextField(
              controller: controller.password,
              obscureText: controller.isHidden,
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
          //button
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: MaterialButton(
              onPressed: () {
                controller.userRegister();
              },
              color: buttonColor,
              textColor: Colors.white,
              minWidth: double.infinity,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // child: const Text(
              //   'Register',
              //   style: TextStyle(fontSize: 25, color: Colors.white),
              // ),
              child: Obx(
                () => controller.loading.value==true
                    ? Container(
                        height: 20,
                        width: 20,
                        child: const CircularProgressIndicator(),
                      )
                    : Text(
                        'Register'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
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
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Login'.tr,
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
