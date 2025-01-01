import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Productcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'Detailpage.dart';
class Searchpage extends StatefulWidget {
  Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final productcontroller=Get.put(Productcontroller());
  @override
  void initState() {
    productcontroller.Fectproduct();
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
            leadingWidth: 25,
            elevation: 0,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                focusColor: Colors.white,
                highlightColor: Colors.white,
                hoverColor: Colors.white,
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            title: TextField(
              onChanged: (value) => productcontroller.updateSearchText(value),
              cursorHeight: BorderSide.strokeAlignCenter,
              decoration:  InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: kcontentColor,
                border: InputBorder.none,
                hintText: 'Search...',
                helperStyle: TextStyle(fontSize: 2,color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          Obx((){
            if (productcontroller.filteredProducts.isEmpty) {
              return SliverFillRemaining(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          height: 200,
                          image: AssetImage('assets/image/empty.png'),
                        ),
                        Text(
                          "Data is Empty",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }else{
              return  SliverList.builder(
                itemCount: productcontroller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = productcontroller.filteredProducts[index];
                  return InkWell(
                    onTap: (){
                      Get.to(Detailpage(title: product.title,id: product.id,));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kcontentColor,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:  BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0; i < 1; i++)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 50,
                                              imageUrl: 'http://10.0.2.2:8000/Image/Product/Image/${product.images[i].image}',
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child:Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(product.title,maxLines:1 ,
                                            overflow: TextOverflow.ellipsis,),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey,fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("\$ " + product.price.toString(),style: TextStyle(color: Colors.red),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }
}
