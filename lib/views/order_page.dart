import 'package:flutter/material.dart';
import 'package:get/get.dart';

class order_page extends StatelessWidget {
  const order_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios)),
        title: Text('Order'),
        elevation: 0,
      ),
    );
  }
}
