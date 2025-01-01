import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Authcontroller.dart';
import 'package:ecommerce/controllers/Categorycontroller.dart';
import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/views/Languagepage.dart';
import 'package:ecommerce/views/about_page.dart';
import 'package:ecommerce/views/feedback_Page.dart';
import 'package:ecommerce/views/order_page.dart';
import 'package:ecommerce/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Settingspage extends StatefulWidget {
  Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  final controller = Tokencontroller();
  final auth = Get.put(Authcontroller());
  final user_data=Get.put(Categorycontroller());
  @override
  void initState() {
    print(user_data.user.length);
    user_data.fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Settinges Pgae",
              style: TextStyle(fontSize: 20),
            ),
            elevation: 0,
            centerTitle: true,
            pinned: true,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          Obx(() =>           SliverList.builder(
            itemCount: user_data.user.length,
            itemBuilder: (context, index) {
              final user = user_data.user[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: InkWell(
                  onTap: (){
                    Get.to(profile_page());
                  },
                  child: Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kcontentColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Center(
                            child: user.image == null
                                ? Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                Icons.person,
                                size: 30,
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 100,
                                    imageUrl: 'http://10.0.2.2:8000/Image/User/Image/${user.image}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Name : ${user.username.toString()}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Text("Email : ${user.email.toString()}",
                                          style: TextStyle(fontSize: 15)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kcontentColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      onTap: ()=>Get.to(order_page()),
                      leading: Icon(Icons.shopping_bag_outlined),
                      title: Text("Orders"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kcontentColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.to(feedback_page());
                      },
                      leading: Icon(Icons.access_time_filled),
                      title: Text("FeedBack"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kcontentColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.to(about_page());
                      },
                      leading: Icon(Icons.info_outline_rounded),
                      title: Text("About"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kcontentColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Langaugepage()),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.language),
                        title: Text("Language".tr),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kcontentColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        auth.logout();
                      },
                      child: ListTile(
                        leading: Icon(Icons.logout_sharp),
                        title: Text("Logout".tr),
                        trailing: Icon(Icons.arrow_forward_ios),
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
