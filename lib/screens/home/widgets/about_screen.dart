import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed:(){
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back,color: Colors.red,)),
        title: RichText(
          text: const TextSpan(
            text: 'A',
            style: TextStyle(
              fontSize: 23,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                  text: 'bout',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, 
      ),
      body: Column(
        children:  [
          const SizedBox(height: 25,),
          Image.asset('assest/images/about.png'),
          const SizedBox(height: 10,),
          const Center(child: Text('PocX is a user friendly money management app')),
          const SizedBox(height: 5,),
          const Text('which allows you to keep track of transactions seamessly.'),
          const SizedBox(height: 5,),
          const Text('It helps you to categorize your spending,'),
          const SizedBox(height: 5,),
          const Text('To create a budget and to stay withinth limit by you, and'),
          const SizedBox(height: 5,),
          const Text('also provides you a deatailed analysis of'),
          const SizedBox(height: 5,),
          const Text(' '),
        ],
      ),
    );
  }
}
