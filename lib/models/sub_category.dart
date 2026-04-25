 import 'package:flutter/material.dart';

class SubCategory {
  final int subCategoryId;
  final int categoryId;
  final String titleSubCatecory;
  final IconData icon;
  final Color color;
  final bool isDownloaded;

  SubCategory({
  required this.subCategoryId,
  required this.categoryId,
  required this.titleSubCatecory,
  required this.icon,
  required this.color,
  required this.isDownloaded ,
  });
}

final List<SubCategory> subCategories = [
  // أفعال
  SubCategory(
    categoryId: 1,
    subCategoryId: 1,
    titleSubCatecory: "أفعال يومية",
    icon: Icons.download,
    color: Colors.blue,
    isDownloaded: false
  ),
  SubCategory(
    categoryId: 1,
    subCategoryId: 2,
    titleSubCatecory: "أفعال رياضية",
    icon: Icons.download,
    color: Colors.blue,
    isDownloaded: false
  ),
  // طعام
  SubCategory(
    categoryId: 2,
    subCategoryId: 3,
    titleSubCatecory: "فواكه",
    icon: Icons.download,
    color: Colors.blue,
    isDownloaded: false
  ),
  SubCategory(
    categoryId: 2,
    subCategoryId: 4,
    titleSubCatecory: "خضروات",
    icon: Icons.download,
    color: Colors.blue,
    isDownloaded: false
  ),
  // عائلة
  SubCategory(
    categoryId: 3,
    subCategoryId: 5,
    titleSubCatecory: "أفراد العائلة",
    icon: Icons.download,
    color: Colors.blue,
    isDownloaded: false
  ),
  // مشاعر
  SubCategory(
    categoryId: 4,
    subCategoryId: 6,
    titleSubCatecory: "مشاعر إيجابية",
    icon: Icons.download,
    color: Colors.blue,
    isDownloaded: false
  ),
  // رياضة
  SubCategory(
    categoryId: 5,
    subCategoryId: 7,
    titleSubCatecory: "كرة القدم",
    icon: Icons.download,
    color: Colors.blue,
    isDownloaded: false
  ),
  SubCategory(
    categoryId: 5,
    subCategoryId: 8,
    titleSubCatecory: "سباحة",
    icon: Icons.download,
    color: Colors.blue,
    isDownloaded: false
  ),
];
