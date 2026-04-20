import 'package:flutter/material.dart';

class Coustombottomnavigation extends StatelessWidget {
  const Coustombottomnavigation({super.key, required this.selectElemnt});
  final selectElemnt;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:70,
      decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
   
      ),
      child: BottomNavigationBar(   
      selectedIconTheme: IconThemeData(size: 35),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 15,
      iconSize: 30,
     backgroundColor:  Color(0xFAFAFAFA),
      currentIndex: selectElemnt,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      items: [
       BottomNavigationBarItem(icon: Icon(Icons.quiz_sharp), label: "إختبار"),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلات"),
      BottomNavigationBarItem(icon: Icon(Icons.download), label: "التنزيلات"),
       BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
    ]),

    );
  }
}
