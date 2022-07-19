import 'package:flutter/material.dart';
import 'package:pocx/screens/category/category_screen.dart';
import 'package:pocx/screens/category/widgets/category_add_popup.dart';
import 'package:pocx/screens/home/widgets/add_transaction.dart';
import 'package:pocx/screens/home/widgets/bottom_navigation.dart';
import 'package:pocx/screens/home/widgets/search_screen.dart';
import 'package:pocx/screens/home/widgets/setting_screen.dart';
import 'package:pocx/screens/transactions/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    const TransactionScreen(),
    const CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.red),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchScreen()));
        }, icon: const Icon(Icons.search_sharp),iconSize: 26,),
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        title: RichText(
          text: const TextSpan(
            text: 'Poc',
            style: TextStyle(
              fontSize: 26,
              color: Colors.red,
              fontWeight: FontWeight.w900,
            ),
            children: [
              TextSpan(
                  text: 'X',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsScreen()));
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.red,
                size: 25,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.red,
        onPressed: () {
          if(selectedIndexNotifier.value == 0){
            Navigator.of(context).pushNamed(AddTransactionScreen.routName);
          }else{
            showCategoryAddPopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
