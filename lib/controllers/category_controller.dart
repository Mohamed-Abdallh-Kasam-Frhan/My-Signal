import 'package:mysignal/models/category.dart';

class CategoryController {
  final List<Category> _categories = mainCategories;

  List<Category> getCategories() {
    return _categories;
  }

  Category getCategoryById(int id) {
    return _categories.firstWhere((category) => category.id == id);
  }
}