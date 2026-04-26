import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key, required this.selectElemnt});
  final int selectElemnt;
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(size: 35),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 15,
        iconSize: 30,
      backgroundColor: customColors.backgroundColor,
        currentIndex: selectElemnt,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: customColors.secondaryTextColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz_sharp), label: "إختبار"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "المفضلات"),
          BottomNavigationBarItem(
              icon: Icon(Icons.download), label: "التنزيلات"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
        ]);
  }
}
