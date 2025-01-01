import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Favoritecontroller.dart';
import 'package:ecommerce/controllers/Productcontroller.dart';
import 'package:ecommerce/models/Productmodel.dart';
import 'package:ecommerce/views/Detailpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Productpage extends StatefulWidget {
  var title,id;
  Productpage({super.key,required this.id,required this.title});

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  @override
  final productcontroller = Get.put(Productcontroller());
  final favoritecontroller=Get.put(Favoritecontroller());
  @override
  void initState() {
    // TODO: implement initState
    productcontroller.fetchproduct_subcategory(widget.id);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
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
              child: Icon(Icons.arrow_back_ios),
            ),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          Obx(() =>productcontroller.loading.value?SliverToBoxAdapter(child: Container( height: MediaQuery.of(context).size.height*0.85,width: 10,child: Center(child: CircularProgressIndicator()),),): SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: productcontroller.products_subcategory.length,
                  (context, index) {
                final product = productcontroller.products_subcategory[index];
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
                                        height: 150,
                                        width: 150,
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
                                                  height: 90,
                                                  fit: BoxFit.cover,
                                                  imageUrl: 'http://10.0.2.2:8000/Image/Product/Image/${product.images[i].image}',
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
                                    productcontroller.fetchproduct_subcategory(widget.id);
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
