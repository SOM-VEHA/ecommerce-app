import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Authcontroller.dart';
import 'package:ecommerce/controllers/Categorycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';

class profile_page extends StatefulWidget {
  profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  final auth = Get.put(Categorycontroller());
  final username=TextEditingController();
  final phone=TextEditingController();
  final address=TextEditingController();
  String? imagePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          auth.fetchUser();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Obx(()=>ListView.builder(
        physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
        ),
        itemCount: auth.user.length,
        itemBuilder: (context, index) {
          final users = auth.user[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///profile
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: InkWell(
                    hoverColor: Colors.white,
                    highlightColor: Colors.white,
                    focusColor: Colors.white,
                    splashColor: Colors.white,
                    onTap: (){
                      pickImage();
                    },
                    // child: Text('dddddddddddddddd'),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: kcontentColor),
                          color: Colors.white
                      ),
                      child: users.image==null?Icon(Icons.perm_identity_outlined,size: 80,):imagePath!=null?ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:CircleAvatar(
                          radius: 40,
                          child:Image.file(
                            File(imagePath!),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ):ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 100,
                          imageUrl: 'http://10.0.2.2:8000/Image/User/Image/${users.image}',
                        ),
                      ),
                    ),
                  ),
                ),
                ///username
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      label: Text(users.username),
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
                ///email
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text(users.email),
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
                ///phone
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: TextField(
                    controller: phone,
                    decoration: InputDecoration(
                      label: users.phone==null?Text('Pleasse Enter Your Phone..'):Text(users.phone.toString()),
                      prefixIcon: Icon(
                        Icons.phone,
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
                ///Address
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kcontentColor,
                    ),
                    child: TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                        hintText: users.address==null?'Pleasse Enter Your Address..':users.address,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        border: InputBorder.none, // Remove the default border
                      ),
                      maxLines: 5,
                    ),
                  ),
                ),
                ///Submit
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        onPressed: () {
                          print('http://10.0.2.2:8000/Image/User/Image/${users.image}');
                          Categorycontroller.updateUser(username: username.text.isEmpty?users.username:username.text, phone: phone.text.isEmpty?users.phone.toString():phone.text, address: address.text.isEmpty?users.address.toString():address.text, imagePath: imagePath);
                          auth.fetchUser();
                        },
                        child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20),)
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
