import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/models/sign_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

// دالة لحساب مسافة التحرير (Levenshtein distance) بين نصين
int calculateEditDistance(String s1, String s2) {
  List<List<int>> dp =
      List.generate(s1.length + 1, (_) => List.filled(s2.length + 1, 0));

  for (int i = 0; i <= s1.length; i++) {
    for (int j = 0; j <= s2.length; j++) {
      if (i == 0) {
        dp[i][j] = j;
      } else if (j == 0) {
        dp[i][j] = i;
      } else if (s1[i - 1] == s2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1];
      } else {
        dp[i][j] = 1 +
            [
              dp[i - 1][j], // حذف
              dp[i][j - 1], // إدراج
              dp[i - 1][j - 1] // استبدال
            ].reduce((a, b) => a < b ? a : b);
      }
    }
  }
  return dp[s1.length][s2.length];
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<dynamic> _allData;
  List<dynamic> _filteredResults = [];

  // دالة لتطبيع النص العربي (إزالة التشكيل وتحويل الحروف المتشابهة)
  static String normalizeArabic(String input) {
    // إزالة التشكيل
    String output = input.replaceAll(RegExp(r'[\u064B-\u0652]'), '');
    // تحويل الحروف المتشابهة
    output = output
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ئ', 'ي')
        .replaceAll('ؤ', 'و')
        .replaceAll('ة', 'ه');
    return output;
  }

  Timer? _debounce; // لمنع البحث المتكرر مع كل حرف

  @override
  void initState() {
    super.initState();
    // دمج البيانات وتحويلها لـ List ثابتة في الذاكرة
    _allData = [...mainCategories, ...mainSigns];
    _filteredResults = _allData;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel(); // تنظيف التايمر عند إغلاق الصفحة
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        setState(() => _filteredResults = _allData);
        return;
      }

      final String normalizedQuery = normalizeArabic(query);

      final List<dynamic> results = _allData.where((item) {
        final String originalTitle =
            item is Category ? item.title : (item as SignModel).title;
        final String normalizedTitle = normalizeArabic(originalTitle);

        // 1. التطابق المباشر أو الاحتواء (سريع)
        if (normalizedTitle.contains(normalizedQuery)) return true;

        // 2. البحث التقريبي (للأخطاء الإملائية)
        // نسمح بفرق حرف واحد فقط إذا كانت الكلمة طويلة (أكثر من 3 حروف)
        if (normalizedQuery.length > 3) {
          int distance =
              calculateEditDistance(normalizedTitle, normalizedQuery);
          if (distance <= 1) return true;
        }

        return false;
      }).toList();

      // ترتيب النتائج: الأقرب للأطول (أو حسب الأهمية)
      results.sort((a, b) {
        final titleA = a is Category ? a.title : (a as SignModel).title;
        final titleB = b is Category ? b.title : (b as SignModel).title;
        return titleA.length.compareTo(titleB.length);
      });

      setState(() => _filteredResults = results);
    });
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Theme.of(context).scaffoldBackgroundColor),
          SafeArea(
            child: Column(
              children: [
                _buildSearchHeader(customColors),
                Expanded(
                  child: _filteredResults.isEmpty
                      ? _buildNoResults(customColors)
                      : ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemCount: _filteredResults.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = _filteredResults[index];
                            return item is Category
                                ? _buildCategoryResult(item, customColors)
                                : _buildSignResult(
                                    item as SignModel, customColors);
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // تصميم نتيجة البحث إذا كانت "تصنيف"
  Widget _buildCategoryResult(
      Category category, AppColorsExtension customColors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: customColors.glassColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: customColors.glassBorder!),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(category.icon, color: category.color),
        ),
        title: Text(category.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: customColors.mainTextColor)),
        subtitle: Text("تصنيف - ${category.numberOf} إشارة",
            style: TextStyle(fontSize: 12, color: customColors.subTextColor)),
        trailing: _typeBadge("تصنيف", category.color),
        onTap: () {/* اذهب لصفحة التصنيف */},
      ),
    );
  }

  // تصميم نتيجة البحث إذا كانت "إشارة"
  Widget _buildSignResult(SignModel sign, AppColorsExtension customColors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: customColors.glassColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: customColors.glassBorder!),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child:
              Image.asset(sign.image, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(sign.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: customColors.mainTextColor)),
        subtitle: Text(sign.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: customColors.subTextColor)),
        trailing: _typeBadge("إشارة", sign.color),
        onTap: () {/* اذهب لصفحة تفاصيل الإشارة */},
      ),
    );
  }

  Widget _typeBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSearchHeader(AppColorsExtension customColors) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: customColors.glassColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: customColors.glassBorder!),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: "ابحث عن أفعال، فواكه، أو إشارات...",
                  prefixIcon: Icon(PhosphorIconsBold.magnifyingGlass,
                      color: customColors.subTextColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(PhosphorIconsBold.arrowRight,
                color: customColors.mainTextColor),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }

  _buildNoResults(AppColorsExtension customColors) {
    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: customColors.glassColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: customColors.glassBorder!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(PhosphorIconsRegular.magnifyingGlass,
              size: 50, color: customColors.subTextColor),
          const SizedBox(height: 20),
          Text("لم يتم العثور على نتائج",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: customColors.mainTextColor)),
          const SizedBox(height: 10),
          Text("حاول البحث بكلمات أخرى أو تأكد من صحة الإملاء.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: customColors.subTextColor)),
        ],
      ),
    );
  }
}
