import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controllers/Productcontroller.dart';
import 'package:ecommerce/views/Productpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/Categorycontroller.dart';
class Subcategorypage extends StatefulWidget {
  Subcategorypage({super.key,required this.title,required this.id});
  String title,id;
  @override
  State<Subcategorypage> createState() => _SubcategorypageState();
}

class _SubcategorypageState extends State<Subcategorypage> {
  final categorycontroller=Get.put(Categorycontroller());
  final productcontroller = Get.put(Productcontroller());
  @override
  void initState() {
    setState(() {
      categorycontroller.fetchSubCategory(widget.id.toString());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          ///app bar
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text(
              widget.title,
              style: TextStyle(fontSize: 20),
            ),
            elevation: 0,
            centerTitle: true,
            pinned: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)
            ),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          ///subcateory
          Obx((){
            if(categorycontroller.isloading.value==true){
              return SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height*0.9,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }else{
              if(categorycontroller.subcategories.length==0){
                return SliverToBoxAdapter(
                  child: Container(
                    color: Colors.red,
                    height: 50,
                    width: 50,
                  ),
                );
              }else{
                return SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Adjust based on your design
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: categorycontroller.subcategories.length,
                  itemBuilder: (context, index) {
                    final subcategories = categorycontroller.subcategories[index];
                    return InkWell(
                      onTap: (){
                        Get.to(Productpage(title: subcategories.title,id: subcategories.id));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child:CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 40,
                                imageUrl: 'http://10.0.2.2:8000/Image/Subcategories/Image/${subcategories.image}',
                                placeholder: (context, url) => Center(
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "${subcategories.title.toString()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }),
        ],
      ),
    );
  }
}