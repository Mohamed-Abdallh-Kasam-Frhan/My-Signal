import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key, required this.selectElemnt});
  final int selectElemnt;
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(  
      type: BottomNavigationBarType.fixed, 
      selectedIconTheme: IconThemeData(size: 35),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 15,
      iconSize: 30,
      backgroundColor: const Color(0xFAFAFAFA),
      currentIndex: selectElemnt,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.quiz_sharp), label: "إختبار"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلات"),
        BottomNavigationBarItem(icon: Icon(Icons.download), label: "التنزيلات"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      ]

    );
  }
}
