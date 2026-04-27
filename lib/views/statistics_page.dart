import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // حزمة الرسوم البيانية
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("إحصائيات الأداء",
            style: TextStyle(
                color: customColors.mainTextColor,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // الخلفية الفنية المعتادة
          Container(color: Theme.of(context).scaffoldBackgroundColor),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // 1. كروت الملخص العلوي (XP, Accuracy, Streak)
                  _buildQuickStats(customColors),

                  const SizedBox(height: 25),
                  // 2. الرسم البياني للنشاط الأسبوعي
                  _buildSectionTitle("نشاطك الأسبوعي", customColors),
                  const SizedBox(height: 15),
                  _buildWeeklyChart(customColors, isDark),

                  const SizedBox(height: 30),
                  // 3. تحليل مستوى الإتقان حسب التصنيف
                  _buildSectionTitle("تحليل الإتقان", customColors),
                  const SizedBox(height: 15),
                  _buildMasteryGrid(customColors),

                  const SizedBox(height: 30),
                  // 4. سجل آخر الاختبارات
                  _buildSectionTitle("آخر النتائج", customColors),
                  const SizedBox(height: 15),
                  _buildRecentHistory(customColors),

                  const SizedBox(height: 100), // مساحة للـ BottomNav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // الكروت العلوية السريعة
  Widget _buildQuickStats(AppColorsExtension customColors) {
    return Row(
      children: [
        _statCard("نقاط الخبرة", "2,450", PhosphorIconsFill.lightning,
            Colors.amber, customColors),
        const SizedBox(width: 12),
        _statCard("الدقة", "88%", PhosphorIconsFill.target, Colors.green,
            customColors),
        const SizedBox(width: 12),
        _statCard(
            "الأيام", "5", PhosphorIconsFill.fire, Colors.orange, customColors),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color,
      AppColorsExtension customColors) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: customColors.glassColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: customColors.glassBorder!),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: customColors.mainTextColor)),
            Text(title,
                style:
                    TextStyle(fontSize: 11, color: customColors.subTextColor)),
          ],
        ),
      ),
    );
  }

  // الرسم البياني الأسبوعي
  Widget _buildWeeklyChart(AppColorsExtension customColors, bool isDark) {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(10, 25, 20, 10),
      decoration: BoxDecoration(
        color: customColors.glassColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: customColors.glassBorder!),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 10,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'];
                  return Text(days[value.toInt()],
                      style: TextStyle(
                          color: customColors.subTextColor, fontSize: 12));
                },
              ),
            ),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _makeGroupData(0, 5, isDark),
            _makeGroupData(1, 8, isDark),
            _makeGroupData(2, 3, isDark),
            _makeGroupData(3, 9, isDark),
            _makeGroupData(4, 6, isDark),
            _makeGroupData(5, 2, isDark),
            _makeGroupData(6, 7, isDark),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, bool isDark) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color:
              isDark ? Colors.blueAccent.withOpacity(0.8) : Colors.blueAccent,
          width: 12,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 10,
            color: Colors.blueAccent.withOpacity(0.05),
          ),
        ),
      ],
    );
  }

  // شبكة الإتقان (Mastery Analysis)
  Widget _buildMasteryGrid(AppColorsExtension customColors) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 2.2,
      children: [
        _masteryItem("الحروف", 0.9, Colors.blue, customColors),
        _masteryItem("الأرقام", 0.4, Colors.orange, customColors),
        _masteryItem("العائلة", 0.7, Colors.green, customColors),
        _masteryItem("الألوان", 0.2, Colors.purple, customColors),
      ],
    );
  }

  Widget _masteryItem(String title, double progress, Color color,
      AppColorsExtension customColors) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: customColors.glassColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: customColors.glassBorder!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: customColors.mainTextColor)),
              Text("${(progress * 100).toInt()}%",
                  style: TextStyle(fontSize: 10, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.1),
            color: color,
            minHeight: 5,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  // سجل النتائج الأخيرة
  Widget _buildRecentHistory(AppColorsExtension customColors) {
    return Column(
      children: List.generate(
          3,
          (index) => Container(
                margin: const EdgeInsets.only(bottom:12),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: customColors.glassColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: index == 0
                          ? Colors.green.withOpacity(0.1)
                          : Colors.amber.withOpacity(0.1),
                      child: Icon(
                          index == 0 ? Icons.emoji_events : Icons.history,
                          color: index == 0 ? Colors.green : Colors.amber,
                          size: 20),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("اختبار الحروف #$index",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: customColors.mainTextColor)),
                          Text("منذ ساعتين",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: customColors.subTextColor)),
                        ],
                      ),
                    ),
                    Text("95%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: customColors.mainTextColor)),
                  ],
                ),
              )),
    );
  }

  Widget _buildSectionTitle(String title, AppColorsExtension customColors) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: customColors.mainTextColor)),
    );
  }
}
