import 'package:flutter/material.dart';
import 'package:mysignal/controllers/category_controller.dart';
import 'package:mysignal/controllers/favorite_controller.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/widgets/sign_card.dart';

class FavoriteLayout extends StatefulWidget {
  const FavoriteLayout({super.key});

  @override
  State<FavoriteLayout> createState() => _FavoriteLayoutState();
}

class _FavoriteLayoutState extends State<FavoriteLayout> {
  final FavoriteController _controller = FavoriteController();

  @override
  Widget build(BuildContext context) {
    final signsList = _controller.getFavorites();
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 100,
        bottom: 100,
      ), // هوامش لعدم التداخل مع الـ AppBars العائمة
      itemCount: signsList.length,
      itemBuilder: (context, index) {
        Category category = CategoryController().getCategoryById(signsList[index].id); // الحصول على التصنيف بناءً على الـ categoryId في الإشارة
        return SignCard(sign: signsList[index], category: category,); // تمرير null للتصنيف لأننا في صفحة المفضلة
      },
    );
  }
}
