import 'dart:io';

import 'package:ecommerce/colors/colors.dart';
import 'package:ecommerce/controllers/feedback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class feedback_page extends StatefulWidget {
  feedback_page({super.key});

  @override
  State<feedback_page> createState() => _feedback_pageState();
}

class _feedback_pageState extends State<feedback_page> {
  @override
  File? image;

  Future pickImage() async {
    final pickedImage  = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage  == null) return;
    final imageTemp = File(pickedImage .path);
    setState(() => image = imageTemp);
  }
  final description=TextEditingController();
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Feedback"),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kcontentColor,
                    ),
                    child: image == null
                        ? const Icon(
                      Icons.image,
                      size: 100,
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: FileImage(image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kcontentColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    border: InputBorder.none, // Remove the default border
                  ),
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  onPressed: () {
                    feedback_controller.feedback(description: description.text,imagePath: image!.path);
                    setState(() {
                        description.clear();image=null;
                    });
                  },
                  child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
