import 'package:ecommerce/controllers/Tokencontroller.dart';
import 'package:ecommerce/models/Languagemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Langaugepage extends StatelessWidget {
  Langaugepage({super.key});
  final controller =new Tokencontroller();
  List<Languagesmodel> list = [
    Languagesmodel(
        id: 1, name: "khmer", img: "assets/image/cambodia.png", key: "KH"),
    Languagesmodel(
        id: 2, name: "English", img: "assets/image/usa.png", key: "US"),
    Languagesmodel(
        id: 3, name: "China", img: "assets/image/china.png", key: "CH"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Langaug Pgae",
              style: TextStyle(fontSize: 20),
            ),
            elevation: 0,
            centerTitle: true,
            pinned: true,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          SliverList.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    onTap: (){
                      Get.updateLocale(Locale(list[index].key));
                      controller.setlanguages(list[index].key);
                      Get.back();
                    },
                    leading:  Image(
                      image: AssetImage(list[index].img),
                    ),
                    title: Text(list[index].name),
                    trailing: Icon(Icons.arrow_forward_ios),
                  )
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
