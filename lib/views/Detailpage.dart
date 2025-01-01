import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Cartcontroller.dart';
import 'package:ecommerce/controllers/Detailcontroller.dart';
import 'package:ecommerce/views/Cartpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detailpage extends StatefulWidget {
  var title, id;
  Detailpage({super.key, required this.title, required this.id});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  final cart_controller = Get.put(Cartcontroller());
  final detailcontroller = Get.put(Detaicontroller());
  var currentIndex = 1;
  var prduct_id;
  RxInt Counter = 1.obs;
  @override
  void initState() {
    detailcontroller.fetchDetail(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){
            Get.to(Cartspage());
          }, icon: Icon(Icons.shopping_bag_outlined))
        ],
      ),
      body: Obx(() {
        if (detailcontroller.isloading.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverList.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final products = detailcontroller.details[index];
                  return Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        //image
                        Stack(
                          children: [
                            Container(
                              height: 300,
                              width: double.infinity,
                              child: CarouselSlider.builder(
                                itemCount: products.images.length,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) {
                                  final image = products.images[itemIndex];
                                  return Container(
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          color: Colors.transparent,
                                          child: Center(
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 200,
                                              imageUrl:
                                                  'http://10.0.2.2:8000/Image/Product/Image/${image.image.toString()}',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  scrollPhysics: BouncingScrollPhysics(),
                                  autoPlay: true,
                                  height: 300,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1.0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: products.images
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentIndex = entry.key;
                                      });
                                    },
                                    child: Container(
                                      width: currentIndex == entry.key ? 17 : 7,
                                      height: 7.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: currentIndex == entry.key
                                            ? Colors.red
                                            : Colors.teal,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        //title
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  products.title,
                                  style: TextStyle(fontSize: 20),
                                  maxLines:1 ,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //price
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$" + products.price.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        //text description
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Description"),
                            ],
                          ),
                        ),

                        ///description
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: Text(
                            products.description,
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // if (currentIndex != 1) {
                          //   setState(() {
                          //     currentIndex--;
                          //   });
                          // }
                          setState(() {
                            if (Counter > 1) {
                              Counter.value--;
                            } else {
                              Counter == 1;
                            }
                          });
                        },
                        iconSize: 18,
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Obx(
                        () => Text(
                          Counter.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Counter.value++;
                          });
                        },
                        iconSize: 18,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.transparent,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        cart_controller.addCarts(widget.id, Counter.toInt());
                      });
                    },
                    color: buttonColor,
                    textColor: Colors.white,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Add To Cart'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
