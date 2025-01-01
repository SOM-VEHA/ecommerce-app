import 'package:ecommerce/controllers/Categorycontroller.dart';
import 'package:ecommerce/controllers/Notificationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notificationpage extends StatefulWidget {
  Notificationpage({super.key});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  final auth=Get.put(Categorycontroller());
  final notificationcontroller=Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(itemCount: auth.user.length,itemBuilder: (context, index) {
        return Text('ddddddddddddddd');
      },),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       backgroundColor: Colors.white,
      //       title: Text(
      //         "Notifications",
      //         style: TextStyle(fontSize: 20),
      //       ),
      //       elevation: 0,
      //       centerTitle: true,
      //       pinned: true,
      //       leading: IconButton(onPressed: (){
      //         Navigator.pop(context);
      //       }, icon: Icon(Icons.arrow_back_ios,size: 30,)),
      //       shadowColor: Colors.transparent,
      //       surfaceTintColor: Colors.transparent,
      //     ),
      //     Obx(() =>  SliverList.builder(
      //       itemCount: notificationcontroller.notification.length,
      //       itemBuilder: (context, index) {
      //         final product = notificationcontroller.notification[index];
      //         return InkWell(
      //           onTap: (){
      //             Get.to(Detailpage(title: product.product.title,id: product.product.id,));
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.all(5.0),
      //             child: Container(
      //               height: 90,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(15),
      //                 color: kcontentColor,
      //               ),
      //               child: Row(
      //                 children: [
      //                   Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Container(
      //                       width: 80,
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(15),
      //                         color: Colors.white,
      //                       ),
      //                       child: Center(
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(10),
      //                           child: Image(
      //                             width: 60,
      //                             height: 60,
      //                             fit: BoxFit.cover,
      //                             image: AssetImage(
      //                                 'product.image'
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child:Container(
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Row(
      //                             children: [
      //                               Text(product.product.title),
      //                             ],
      //                           ),
      //                           Row(
      //                             children: [
      //                               Expanded(
      //                                 child: Text(
      //                                   product.product.description,
      //                                   maxLines: 2,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   style: TextStyle(color: Colors.grey,fontSize: 12),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                           Row(
      //                             children: [
      //                               Text("\$ " + product.product.price.toString(),style: TextStyle(color: Colors.red),),
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     ),)
      //   ],
      // ),
    );
  }
}
