import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Categorycontroller.dart';
import 'package:ecommerce/controllers/Favoritecontroller.dart';
import 'package:ecommerce/controllers/Productcontroller.dart';
import 'package:ecommerce/api/api.dart';
import 'package:ecommerce/controllers/Slidercontroller.dart';
import 'package:ecommerce/views/Detailpage.dart';
import 'package:ecommerce/views/Notificationpage.dart';
import 'package:ecommerce/views/Searchspage.dart';
import 'package:ecommerce/views/Settingpage.dart';
import 'package:ecommerce/views/subcategorypage.dart';
import 'package:ecommerce/views/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final slidercontroller = Get.put(Slidercontroller());
  final categorycontroller = Get.put(Categorycontroller());
  final productcontroller = Get.put(Productcontroller());
  final favoritecontroller=Get.put(Favoritecontroller());
  @override
  void initState() {
    slidercontroller.fetchSliders();
    categorycontroller.fetchCategory();
    productcontroller.Fectproduct();
    favoritecontroller.fetchFavorite();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          //appbar
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Home Pgae",
              style: TextStyle(fontSize: 20),
            ),
            elevation: 0,
            centerTitle: true,
            pinned: true,
            leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settingspage()),
                );
              },
              child: Container(
                width: 90,
                decoration: BoxDecoration(color: Colors.transparent),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(itemCount: categorycontroller.user.length,itemBuilder: (context, index) {
                    final user=categorycontroller.user[index];
                    return  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 40,
                        imageUrl: 'http://10.0.2.2:8000/Image/User/Image/${user.image.toString()}',
                      ),
                    );
                  },)
                )),
              ),
            ),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            actions: [
              InkWell(
                onTap: () {
                  Get.to(UserProfileScreen());
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.notifications_none_rounded,
                        size: 30,
                      ),
                    ),
                    Positioned(
                      top: 9,
                      right: 13,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        child: GestureDetector(
                            onTap: () {
                              // farvorite_local_controller.toggleFavorite(product);
                            },
                            child: Text(
                              '1',
                              style: TextStyle(color: Colors.red),
                            ),),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          //search
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 18),
              child: InkWell(
                onTap: (){
                  Get.to(Searchpage());
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kcontentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 55,
                        width: 55,
                        child: Center(child: Icon(Icons.search,color: Colors.grey,size:30,)),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Text('Search...',style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              Container(
                                height: 55,
                                width: 55,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 1.5,
                                      color: Colors.grey,
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.tune,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // slider
          Obx(() => SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: CarouselSlider(
                    items: slidercontroller.slider.map((item) {
                      return Container(
                        height: 200,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: double.infinity,
                              imageUrl: api.image + "Slider/image/" + item.image,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          slidercontroller.currentIndex = index;
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
                    children:
                    slidercontroller.slider.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            slidercontroller.currentIndex = entry.key;
                          });
                        },
                        child: Container(
                          width: slidercontroller.currentIndex == entry.key
                              ? 17
                              : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: slidercontroller.currentIndex == entry.key
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
          ),),
          //Text Category
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Center(child: Text('ALL Categorys',style: TextStyle(fontSize: 15,color: Colors.white),))
              ),
            ),
          ),
          // menu
          Obx(() =>  SliverPadding(
            padding: EdgeInsets.only(left: 5,right: 5),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Adjust based on your design
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: categorycontroller.category.length,
              itemBuilder: (context, index) {
                final categories = categorycontroller.category[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      categorycontroller.fetchSubCategory(categories.id.toString());
                      Get.to(Subcategorypage(
                        title: categories.title.toString(),id: categories.id.toString(),
                      ));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child:  ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                              imageUrl: api.image + "Categories/image/" + categories.image,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "${categories.title}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 7,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),),
          //Text product
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Center(child: Text('ALL Products',style: TextStyle(fontSize: 15,color: Colors.white),))
              ),
            ),
          ),
          // product
          Obx(() => SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: productcontroller.products.length,
                  (context, index) {
                final product = productcontroller.products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Detailpage(title: product.title,id: product.id,)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kcontentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 140,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            for (int i = 0; i < 1; i++)
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  height: 90,
                                                  imageUrl: 'http://10.0.2.2:8000/Image/Product/Image/${product.images[i].image}',
                                                  placeholder: (context, url) => Center(
                                                    heightFactor: 5,
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        product.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${product.price}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 18,
                                              color: Colors.deepOrange,
                                            ),
                                            Text('(4.5)')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    favoritecontroller.remove_add(product.id.toString());
                                    productcontroller.Fectproduct();
                                  });
                                },
                                child:product.is_favorite==1?Icon(
                                  Icons.favorite ,
                                  color: Colors.red,
                                ):Icon(
                                  Icons.favorite_border, color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 0.75,
            ),
          ),),
        ],
      ),
    );
  }
}
