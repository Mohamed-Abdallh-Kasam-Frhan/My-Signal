import 'package:flutter/material.dart';
import 'package:mysignal/models/Categoris.dart';

class HomeController {
  List<Category> getCategories() {
    return mainCategories;
  }


  List<Category> getMainItemsForCategory(int categoryId) {
    final category = mainCategories.firstWhere((cat) => cat.id == categoryId);
    return category.subItems ?? [];
  }


  // void onCategoryTap(BuildContext context, Category category) {
  //   // Show main items directly without subcategories navigation
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Selected category: ${category.title}'),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }
}
