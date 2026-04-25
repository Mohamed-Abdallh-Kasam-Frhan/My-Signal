import 'package:flutter/material.dart';
import 'package:mysignal/controllers/home_controller.dart';
import 'package:mysignal/widgets/category_card.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final HomeController _controller = HomeController();
  @override
  Widget build(BuildContext context) {
    final categories = _controller.getCategories();
    return Container(
      color: const Color(0xFAFAFAFA),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              // onTap: () => _controller.onCategoryTap(context, category),
              child: CategoryCard(element: category),
            );
          },
        ),
      ),
    );
  }
}
