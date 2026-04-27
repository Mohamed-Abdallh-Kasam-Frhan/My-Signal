import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/models/exam_category.dart';
import 'package:mysignal/views/category_tests_page.dart';
import 'package:mysignal/views/statistics_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExamCategoriesLayout extends StatelessWidget {
  const ExamCategoriesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;

    // بيانات تجريبية
    final List<ExamCategory> examCategories = [
      ExamCategory(
          title: "الحروف الأبجدية",
          icon: PhosphorIconsFill.textAUnderline,
          color: Colors.blue,
          totalExams: 5,
          categoryId: 1,
          progress: 0.8),
      ExamCategory(
          title: "الأرقام والحساب",
          icon: PhosphorIconsFill.numberSquareOne,
          color: Colors.orange,
          totalExams: 3,
          categoryId: 2,
          progress: 0.4),
      ExamCategory(
          title: "الأفعال الشائعة",
          icon: PhosphorIconsFill.lightning,
          color: Colors.green,
          totalExams: 8,
          categoryId: 3,
          progress: 0.1),
      ExamCategory(
          title: "العائلة والمجتمع",
          icon: PhosphorIconsFill.usersThree,
          color: Colors.purple,
          totalExams: 4,
          categoryId: 4,
          progress: 0.0),
    ];

    return ListView.builder(
      // Padding مخصص ليتناسب مع الـ AppBar والـ BottomNav الزجاجي
      padding: const EdgeInsets.fromLTRB(20, 110, 20, 110),
      itemCount: examCategories.length + 1, // +1 من أجل قسم الإحصائيات العلوي
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildStatsHeader(context, customColors);
        }
        return _buildExamCategoryCard(
            context, examCategories[index - 1], customColors);
      },
    );
  }

  // قسم إحصائيات سريع في الأعلى لزيادة التفاعل
  Widget _buildStatsHeader(
      BuildContext context, AppColorsExtension customColors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border:
            Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const StatisticsPage(),
            ),
          );
          // Handle tap on stats header
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor,
              child:
                  const Icon(PhosphorIconsFill.chartBar, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "مستوى التقدم العام",
                    style: TextStyle(
                        color: customColors.mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "لقد أكملت 12 اختباراً بنجاح هذا الأسبوع!",
                    style: TextStyle(
                        color: customColors.subTextColor, fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: customColors.subTextColor),
          ],
        ),
      ),
    );
  }

  // بطاقة تصنيف الاختبار المحدثة
  Widget _buildExamCategoryCard(BuildContext context, ExamCategory item,
      AppColorsExtension customColors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: customColors.glassColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: customColors.glassBorder!),
      ),
      child: InkWell(
        onTap: () {
            context.push('/exams/category/${item.categoryId}?title=${item.title}'); // نمرر الـ id والعنوان في الرابط
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => CategoryTestsPage(category: item),
          //   ),
          // );
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // أيقونة التصنيف
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(item.icon, color: item.color, size: 30),
              ),
              const SizedBox(width: 15),
              // معلومات الاختبار
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: customColors.mainTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${item.totalExams} اختبارات متوفرة",
                      style: TextStyle(
                          color: customColors.subTextColor, fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    // شريط التقدم (Progress Bar)
                    Stack(
                      children: [
                        Container(
                          height: 6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: item.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: item.progress,
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: item.color,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: item.color.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // نسبة الإنجاز كنص
              Text(
                "${(item.progress * 100).toInt()}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: item.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
