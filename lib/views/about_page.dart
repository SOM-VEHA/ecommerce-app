import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../colors/colors.dart';
class about_page extends StatelessWidget {
  const about_page({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("About Me"),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios),),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: kcontentColor,
                child: Column(
                  children: [
                    Text('ChatGPT is an AI conversational model developed by OpenAI, part of the Generative Pre-trained Transformer (GPT) series. It originated from advancements in the Transformer architecture introduced in 2017. OpenAI released GPT-1 in 2018, focusing on unsupervised pre-training for text understanding. This was followed by GPT-2 in 2019, which showcased significant progress in generating coherent and contextually relevant text. GPT-3, launched in 2020, further expanded capabilities with 175 billion parameters, enabling detailed and versatile responses. ChatGPT, built on GPT-3.5 and later GPT-4, fine-tuned conversational AI for interactive and human-like dialogue, becoming widely accessible through platforms like OpenAI’s API and ChatGPT apps.'),
                    Text("My name is Somveha. I am from Tbong Khmum Province. Currently, I live in Phnom Penh, Depo 3. I am a student at RUPP Phnom Penh, majoring in Information Technology, in my 4th year. I have experience with projects such as developing a mobile app using Laravel (Backend) and Flutter (Frontend). Additionally, and network configuration, including switch and router",style: TextStyle(color: Colors.red),)
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
