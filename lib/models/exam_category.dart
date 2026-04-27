import 'package:flutter/material.dart';

class ExamCategory {
  final String title;
  final IconData icon;
  final Color color;
  final int totalExams;
  final int categoryId; // معرف التصنيف لربطه بالاختبارات والإشارات
  final double progress; // نسبة الإنجاز من 0.0 إلى 1.0

  ExamCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.totalExams,
    required this.progress,
    required this.categoryId,
  });
}
