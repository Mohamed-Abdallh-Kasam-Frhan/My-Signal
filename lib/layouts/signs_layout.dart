import 'package:flutter/material.dart';
import 'package:mysignal/controllers/favorite_controller.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/models/sign_model.dart';
import 'package:mysignal/widgets/sign_card.dart';

class SignsLayout extends StatefulWidget {
  const SignsLayout(
      {super.key, required this.category, required this.onSignTap});
  final Category category;
  final Function(SignModel) onSignTap;

  @override
  State<SignsLayout> createState() => _SignsLayoutState();
}

class _SignsLayoutState extends State<SignsLayout> {
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
        return GestureDetector(
          onTap: () {
            widget.onSignTap(signsList[index]);
          },
          child: SignCard(
            sign: signsList[index],
            categoryName: widget.category.title,
          ),
        );
      },
    );
  }
}
