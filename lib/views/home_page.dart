import 'dart:ui';

import 'package:flutter/material.dart';
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _buildModernAppBar(context, title: "التصنيفات"),
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

  PreferredSizeWidget _buildModernAppBar(BuildContext context,
      {required String title}) {
    return PreferredSize(
      // تحديد الارتفاع الكلي للشريط مع الهوامش
      preferredSize: const Size.fromHeight(100),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              // زيادة الضبابية لتعطي ملمس الزجاج الفاخر
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  // استخدام الأبيض الشفاف بدلاً من الرمادي يعطي نقاءً للتصميم
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(PhosphorIconsRegular.magnifyingGlass,
                              color: Colors.black87),
                          onPressed: () {},
                        ),
                      ),

                      // العنوان في المنتصف
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),

                      IconButton(
                        icon: const Icon(PhosphorIconsRegular.list,
                            color: Colors.black87),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
