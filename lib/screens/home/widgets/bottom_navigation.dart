import 'package:flutter/material.dart';
import 'package:pocx/screens/home/home_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:  HomeScreen.selectedIndexNotifier,
      builder: (BuildContext context, int updatedIndex, Widget?_){
        return BottomNavigationBar(
        currentIndex: updatedIndex,
        onTap: (newIndex){
          HomeScreen.selectedIndexNotifier.value = newIndex;
        },
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontSize: 11),
        unselectedFontSize: 10,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined,size: 18,),
          label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined,size: 18,),
            label: 'Category',
            ),
        ],
        );
      },
    );
  }
}