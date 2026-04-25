import 'package:flutter/material.dart';
import 'package:mysignal/controllers/home_controller.dart';
import 'package:mysignal/widgets/CategorisCard.dart';
import 'package:mysignal/widgets/appBar.dart';
import 'package:mysignal/widgets/CoustomBottomNavigation.dart';

 class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    final categories = _controller.getCategories();
    return Scaffold(
      appBar: const CustomAppBar(
        title: "التصنيفات",
        actions: [
          Icon(Icons.search),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
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
      ),
      bottomNavigationBar: const CustomBottomNavigation(selectElemnt: 3),
    );
  }
}