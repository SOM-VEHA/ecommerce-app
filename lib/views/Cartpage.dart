import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Cartcontroller.dart';
import 'package:ecommerce/views/Detailpage.dart';
import 'package:ecommerce/views/check_out.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Cartspage extends StatefulWidget {
  Cartspage({super.key});

  @override
  State<Cartspage> createState() => _CartspageState();
}

class _CartspageState extends State<Cartspage> {
  final cartcontroller = Get.put(Cartcontroller());
  @override
  void initState() {
    cartcontroller.fetchCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Carts Pgae",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Obx(() {
        if (cartcontroller.carts.length == 0) {
          return Container(
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
                  Text("Data is Empty",style: TextStyle(color: Colors.red),)
                ],
              ),
            ),
          );
        } else {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverList.builder(
                itemCount: cartcontroller.carts.length,
                itemBuilder: (context, index) {
                  final product = cartcontroller.carts[index];
                  return InkWell(
                    onTap: (){
                      Get.to(Detailpage(
                        title: product.product.title,
                        id: product.product.id,
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kcontentColor,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 1; i++)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: 100,
                                          imageUrl: 'http://10.0.2.2:8000/Image/Product/Image/${product.product.images[i].image}',
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, right: 8),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(product.product.title.toString(),style: TextStyle(fontSize: 20),
                                                  maxLines:1 ,
                                                  overflow: TextOverflow.ellipsis,),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  product.product.description.toString(),
                                                  maxLines: 3,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "\$ " +
                                                    product.totalprice.toString(),
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                                  color: kcontentColor,
                                                  border: Border.all(
                                                    color:
                                                    Colors.grey.shade400,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartcontroller.addCounter(product.product_id,product.qty + 1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(product.qty.toString()),
                                                    const SizedBox(width: 10),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          int qty = product.qty - 1;
                                                          int totalprice = qty * product.product.price.toInt();
                                                          if (qty <= 0) {
                                                            print(qty);
                                                            print(totalprice);
                                                          } else {
                                                            cartcontroller.addCounter(product.product_id,product.qty - 1);
                                                          }
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
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
                                            cartcontroller.removeCarts(product.id.toString());
                                          },
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "SbuTotal",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "\$100",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "\$${cartcontroller.totalPrice.toString()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor,
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        onPressed: () {
                          Get.to(checkout_page());
                        },
                        child: const Text(
                          "Check Out",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },),
    );
  }
}
