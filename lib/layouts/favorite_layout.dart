import 'package:flutter/material.dart';

class FavoriteLayout extends StatefulWidget {
  const FavoriteLayout({super.key});

  @override
  State<FavoriteLayout> createState() => _FavoriteLayoutState();
}

class _FavoriteLayoutState extends State<FavoriteLayout> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Favorite"));
  }
}