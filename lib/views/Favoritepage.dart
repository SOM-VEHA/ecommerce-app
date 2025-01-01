import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Favoritecontroller.dart';
import 'package:ecommerce/views/Detailpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class Favoritepage extends StatefulWidget {
  Favoritepage({super.key});

  @override
  State<Favoritepage> createState() => _FavoritepageState();
}

class _FavoritepageState extends State<Favoritepage> {
  final favoritecontroller = Get.put(Favoritecontroller());
  @override
  void initState() {
    favoritecontroller.fetchFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Favorits Pgae",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          Obx(() {
            if (favoritecontroller.favorites.length == 0) {
              return SliverToBoxAdapter(
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
            } else {
              return SliverList.builder(
                itemCount: favoritecontroller.favorites.length,
                itemBuilder: (context, index) {
                  final product = favoritecontroller.favorites[index];
                  // final image = product.product.images[index];
                  return InkWell(
                    onTap: () {
                      Get.to(Detailpage(
                        title: product.product.title,
                        id: product.product.id,
                      ));
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
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0; i < 1; i++)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 50,
                                              imageUrl:
                                                  'http://10.0.2.2:8000/Image/Product/Image/${product.product.images[i].image}',
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                product.product.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                product.product.description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "\$ " +
                                                  product.product.price
                                                      .toString(),
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
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
                                          favoritecontroller.remove_add(
                                              product.product.id.toString());
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
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
