import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/models/exam_category.dart';
import 'package:mysignal/models/test_model.dart';
import 'package:mysignal/views/take_test_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CategoryTestsPage extends StatelessWidget {
  final ExamCategory category;
  const CategoryTestsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;

    // بيانات تجريبية لمحاكاة الحالات المختلفة
    final List<TestModel> tests = [
      TestModel(
          title: "اختبار الحروف الأساسية 1",
          status: TestStatus.passed,
          score: 95,
          totalQuestions: 10),
      TestModel(
          title: "اختبار الحروف المتشابهة",
          status: TestStatus.inProgress,
          totalQuestions: 10,
          answeredQuestions: 5),
      TestModel(
          title: "الاختبار الشامل للحروف",
          status: TestStatus.failed,
          score: 40,
          totalQuestions: 20),
      TestModel(
          title: "تحدي السرعة: الحروف",
          status: TestStatus.notStarted,
          totalQuestions: 15),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(category.title,
            style: TextStyle(
                color: customColors.mainTextColor,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Stack(
        children: [
          // خلفية التدرج
          Container(color: Theme.of(context).scaffoldBackgroundColor),

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildCategoryStatsHeader(context, customColors),
                const SizedBox(height: 25),
                Text("الاختبارات المتاحة",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: customColors.mainTextColor)),
                const SizedBox(height: 15),
                ...tests
                    .map((test) => _buildTestCard(context, test, customColors))
                    .toList(),
                const SizedBox(height: 100), // مساحة إضافية في الأسفل
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 1. رأس الصفحة: الإحصائيات وزر التعلم
  Widget _buildCategoryStatsHeader(
      BuildContext context, AppColorsExtension customColors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: customColors.glassColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: customColors.glassBorder!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem("معدل النجاح", "85%", Colors.green),
              _statItem("المكتملة", "3/10", Colors.blue),
              _statItem("المرتبة", "#12", Colors.orange),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: customColors.glassBorder),
          const SizedBox(height: 10),
          // زر الانتقال لـ SignsLayout للمراجعة
          ElevatedButton.icon(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     // builder: (context) => SignsLayout(category: category, onSignTap: ,),
              //   ),
              // );
              // Navigator.push... لصفحة SignsLayout
            },
            icon: const Icon(PhosphorIconsFill.bookOpenText, size: 20),
            label: const Text("راجع المصطلحات قبل الاختبار",
                style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // 2. بطاقة الاختبار الذكية
  Widget _buildTestCard(
      BuildContext context, TestModel test, AppColorsExtension customColors) {
    Color statusColor;
    IconData statusIcon;
    String statusText = "";

    // منطق تحديد المظهر بناءً على الحالة
    switch (test.status) {
      case TestStatus.passed:
        statusColor = Colors.green;
        statusIcon = PhosphorIconsFill.checkCircle;
        statusText = "ناجح - ${test.rating}";
        break;
      case TestStatus.failed:
        statusColor = Colors.red;
        statusIcon = PhosphorIconsFill.xCircle;
        statusText = "تحتاج إعادة - ${test.rating}";
        break;
      case TestStatus.inProgress:
        statusColor = Colors.orange;
        statusIcon = PhosphorIconsFill.playCircle;
        statusText =
            "قيد التقدم (${test.answeredQuestions}/${test.totalQuestions})";
        break;
      case TestStatus.notStarted:
        statusColor = Colors.grey;
        statusIcon = PhosphorIconsFill.circle;
        statusText = "لم يبدأ بعد";
        break;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TakeTestPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: customColors.glassColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: test.status == TestStatus.notStarted
                ? customColors.glassBorder!
                : statusColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            // أيقونة الحالة مع نبض لوني خفيف
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(statusIcon, color: statusColor, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(test.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: customColors.mainTextColor)),
                  const SizedBox(height: 5),
                  Text(statusText,
                      style: TextStyle(
                          fontSize: 13,
                          color: statusColor,
                          fontWeight: FontWeight.w500)),
      
                  // عرض شريط تقدم إذا كان الاختبار قيد العمل
                  if (test.status == TestStatus.inProgress) ...[
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: test.answeredQuestions / test.totalQuestions,
                      backgroundColor: statusColor.withOpacity(0.1),
                      color: statusColor,
                      borderRadius: BorderRadius.circular(5),
                      minHeight: 4,
                    ),
                  ]
                ],
              ),
            ),
      
            // عرض الدرجة في حال النجاح أو الرسوب
            if (test.score != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "%${test.score!.toInt()}",
                  style:
                      TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                ),
              ),
      
            if (test.status == TestStatus.notStarted)
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
