import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mysignal/controllers/home_controller.dart';
import 'package:mysignal/layouts/exam_categories_layout.dart';
import 'package:mysignal/layouts/favorite_layout.dart';
import 'package:mysignal/layouts/home_layout.dart';
import 'package:mysignal/widgets/app_bar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeController _controller = HomeController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = _controller.getCategories();
    return Scaffold(
      extendBody: true,
      appBar: const CustomAppBar(
        title: "التصنيفات",
        actions: [
          Icon(Icons.search),
          SizedBox(width: 10),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ExamCategoriesLayout(),
          FavoriteLayout(),
          HomeLayout(),
        ],
      ),
      bottomNavigationBar: _buildBlurredBottomNav(),
    );
  }

  Widget _buildBlurredBottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 80,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.black54,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedFontSize: 16,
                unselectedFontSize: 12,
                selectedIconTheme: const IconThemeData(size: 35),
                unselectedIconTheme: const IconThemeData(size: 30),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.question),
                    label: "إختبار",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.heart), // غير محدد (مفرغ)
                    label: "المفضلات",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.house),
                    label: "الرئيسية",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
