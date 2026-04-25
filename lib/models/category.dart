import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;
  final IconData icon;
  final Color color;
  final int numberOf;
  final List<Category>? subItems;

  Category({
    required this.id,
    required this.title,
    required this.numberOf,
    required this.icon,
    required this.color,
    this.subItems,
  });
}

final List<Category> mainCategories = [
  Category(
    id: 1,
    title: "أفعال",
    numberOf: 500,
    icon: Icons.directions_run,
    color: Colors.blue,
  ),
  Category(
    id: 2,
    title: "طعام",
    numberOf: 0,
    icon: Icons.fastfood,
    color: Colors.blue,
  ),
  Category(
    id: 3,
    title: "عائلة",
    numberOf: 0,
    icon: Icons.family_restroom,
    color: Colors.blue,
  ),
  Category(
    id: 4,
    title: "مشاعر",
    numberOf: 0,
    icon: Icons.emoji_emotions,
    color: Colors.blue,
  ),
  Category(
    id: 5,
    title: "رياضة",
    numberOf: 0,
    icon: Icons.sports_soccer,
    color: Colors.blue,
  ),
  Category(
    id: 6,
    title: "أرقام",
    numberOf: 0,
    icon: Icons.format_list_numbered,
    color: Colors.blue,
    subItems: [
      Category(id: 601, title: "1", numberOf: 0, icon: Icons.looks_one, color: Colors.blue),
      Category(id: 602, title: "2", numberOf: 0, icon: Icons.looks_two, color: Colors.blue),
      Category(id: 603, title: "3", numberOf: 0, icon: Icons.looks_3, color: Colors.blue),
      Category(id: 604, title: "4", numberOf: 0, icon: Icons.looks_4, color: Colors.blue),
      Category(id: 605, title: "5", numberOf: 0, icon: Icons.looks_5, color: Colors.blue),
    ]   
  ),
  Category(
    id: 7,
    title: "حيوانات",
    numberOf: 0,
    icon: Icons.pets,
    color: Colors.blue,
    subItems: [
      Category(id: 701, title: "قطة", numberOf: 0, icon: Icons.pets, color: Colors.blue),
      Category(id: 702, title: "كلب", numberOf: 0, icon: Icons.pets, color: Colors.blue),
      Category(id: 703, title: "طائر", numberOf: 0, icon: Icons.flight, color: Colors.blue),
      Category(id: 704, title: "سمكة", numberOf: 0, icon: Icons.pets, color: Colors.blue),
    ],
  ),
];
