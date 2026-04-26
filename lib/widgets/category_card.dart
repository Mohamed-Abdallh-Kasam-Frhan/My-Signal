import 'package:flutter/material.dart';
import 'package:mysignal/models/category.dart';
class CategoryCard extends StatelessWidget {
  final Category element;
  const CategoryCard({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return Container(
      // جعل البطاقة تبدو كأنها تطفو بفضل الظل الملون
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: element.color.withOpacity(0.12), // ظل بلون الفئة نفسها
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 1. أيقونة خلفية عملاقة وشفافة جداً لتعطي مظهر فني (Watermark effect)
          Positioned(
            left: -15,
            bottom: -15,
            child: Icon(
              element.icon,
              size: 100,
              color: element.color.withOpacity(0.05),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // محاذاة لليمين أو اليسار تعطي طابعاً عصرياً أكثر
              children: [
                // 2. حاوية الأيقونة (مربعة بزوايا منحنية بدلاً من الدائرة)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: element.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    element.icon,
                    size: 28,
                    color: element.color,
                  ),
                ),
                const Spacer(), // دفع النصوص للأسفل

                // 3. النصوص بتنسيق هرمي (Title then subtitle)
                Text(
                  element.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800, // خط عريض جداً
                    color: Color(0xFF2D2D2D),
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 4),

                if (element.numberOf > 0)
                  Text(
                    "${element.numberOf} عنصر",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
