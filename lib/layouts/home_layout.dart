import 'package:flutter/material.dart';
import 'package:mysignal/controllers/home_controller.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/widgets/category_card.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key, required this.onCategoryTap});

  final Function(Category) onCategoryTap;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final HomeController _controller = HomeController();
  @override
  Widget build(BuildContext context) {
    final categories = _controller.getCategories();
    return GridView.builder(
      padding: const EdgeInsets.only(
        top: 100,
        bottom: 110,
        left: 20,
        right: 20,
      ), // هوامش لعدم التداخل مع الـ AppBars العائمة
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width < 400
            ? 1
            : MediaQuery.of(context).size.width < 700
                ? 2
                : MediaQuery.of(context).size.width < 1000
                    ? 3
                    : 4,
        crossAxisSpacing: 15, // مسافة أفقية أكبر
        mainAxisSpacing: 15, // مسافة رأسية أكبر
        childAspectRatio: 0.85, // جعل البطاقة أطول قليلاً لتبدو أكثر رشاقة
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            // نستخدم الـ Navigator الداخلي
            widget.onCategoryTap(category);
          },
          child: CategoryCard(element: category),
        );
      },
    );
  }
}
