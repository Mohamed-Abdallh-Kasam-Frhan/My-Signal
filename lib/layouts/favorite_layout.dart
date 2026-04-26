import 'package:flutter/material.dart';
import 'package:mysignal/controllers/favorite_controller.dart';
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
        return SignCard(sign: signsList[index]);
      },
    );
  }
}
