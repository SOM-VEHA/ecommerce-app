import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/Authcontroller.dart';
import 'package:ecommerce/controllers/Cartcontroller.dart';
import 'package:ecommerce/controllers/Categorycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class checkout_page extends StatefulWidget {
  checkout_page({super.key});

  @override
  State<checkout_page> createState() => _checkout_pageState();
}

class _checkout_pageState extends State<checkout_page> {
  final cartcontroller=Get.put(Cartcontroller());
  final test=Get.put(Authcontroller());
  final auth = Get.put(Categorycontroller());
  String delevery_method = '1';
  String payment_method = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Checkout"),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverList.builder(itemCount: cartcontroller.carts.length,itemBuilder: (context, index) {
            final product = cartcontroller.carts[index];
            return Padding(
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
                      padding: const EdgeInsets.all(8.0),
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
                                      height: 55,
                                      imageUrl: 'http://10.0.2.2:8000/Image/Product/Image/${product.product.images[i].image}',
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
                                Text(product.product.title),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.product.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey,fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("\$ " + product.product.price.toString(),style: TextStyle(color: Colors.red),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },),
          SliverList.builder(itemCount: 1,itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kcontentColor,
                    ),
                    child:   Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery method"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.store),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Pick up at Store".tr),
                                  ),
                                ],
                              ),
                              // Icon(Icons.arrow_forward_ios_sharp),
                              Container(
                                height: 12,
                                width: 12,
                                child: Radio(
                                  value: '1',
                                  groupValue: delevery_method,
                                  onChanged: (String? value) {
                                    setState(() {
                                      delevery_method = value!;
                                      print(delevery_method);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15, right: 15,bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.sports_motorsports_outlined),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Delivery to Door".tr),
                                  ),
                                ],
                              ),
                              // Icon(Icons.arrow_forward_ios_sharp),
                              Container(
                                height: 12,
                                width: 12,
                                child: Radio(
                                  value: '0',
                                  groupValue: delevery_method,
                                  onChanged: (String? value) {
                                    setState(() {
                                      delevery_method = value!;
                                      print(delevery_method);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kcontentColor,
                    ),
                    child:   Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(delevery_method=="1"?"Addresss Store":"Delevery Address"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15, right: 15,bottom: 15),
                          child: delevery_method=='1'?Text("House 1200, Street 3, Sangkat Boeung Keng Kang 2, Phnom Penh, Phnom Penh Province"):Container(height:35,
                            child: ListView.builder(itemCount:auth.user.length,itemBuilder: (context, index) {
                              final user=auth.user[index];
                              return Text(user.address.toString());
                            },),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kcontentColor,
                    ),
                    child:  Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Shopping Fee :"), Text('\$${cartcontroller.totalPrice*0.05}')],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Tax Fee :"), Text('\$${cartcontroller.totalPrice*0.1}')],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Order Total :"), Text('\$${cartcontroller.totalPrice.toString()}')],
                          ),
                        ),
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payment Method"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.payments_outlined),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Pay Onlion".tr),
                                  ),
                                ],
                              ),
                              // Icon(Icons.arrow_forward_ios_sharp),
                              Container(
                                height: 12,
                                width: 12,
                                child: Radio(
                                  value: '1',
                                  groupValue: payment_method,
                                  onChanged: (String? value) {
                                    setState(() {
                                      payment_method = value!;
                                      print(payment_method);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        delevery_method=="1"?
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15, right: 15,bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.store),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Pay at Store".tr),
                                  ),
                                ],
                              ),
                              Container(
                                height: 12,
                                width: 12,
                                child: Radio(
                                  value: delevery_method=="1"?'0':"1",
                                  groupValue: payment_method,
                                  onChanged: (String? value) {
                                    setState(() {
                                      payment_method = value!;
                                      print(payment_method);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ):const Text(''),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },)
        ],
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white,
          height: 60,
          width: 250,
          child:ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kprimaryColor,
              minimumSize: const Size(double.infinity, 55),
            ),
            onPressed: () {
              print('object');
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
        ),
      ),
    );
  }
}
