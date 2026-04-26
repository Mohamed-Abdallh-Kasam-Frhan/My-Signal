class SearchController {

  static String normalizeArabic(String text) {
    if (text.isEmpty) return text;

    // توحيد الألف (أ، إ، آ) إلى (ا)
    text = text.replaceAll(RegExp(r'[أإآ]'), 'ا');
    // توحيد التاء المربوطة (ة) إلى (ه)
    text = text.replaceAll('ة', 'ه');
    // توحيد الياء (ى) إلى (ي)
    text = text.replaceAll('ى', 'ي');
    // إزالة التشكيل (الفتحة، الضمة، الكسرة، إلخ)
    text = text.replaceAll(RegExp(r'[\u064B-\u0652]'), '');

    return text.trim().toLowerCase();
  }

  static int calculateEditDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<int> v0 = List<int>.generate(s2.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(s2.length + 1, 0);

    for (int i = 0; i < s1.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < s2.length; j++) {
        int cost = (s1[indexAt(s1, i)] == s2[indexAt(s2, j)]) ? 0 : 1;
        v1[j + 1] = [v1[j] + 1, v0[j + 1] + 1, v0[j] + cost]
            .reduce((curr, next) => curr < next ? curr : next);
      }
      v0 = List.from(v1);
    }
    return v0[s2.length];
  }

// مساعدة للتعامل مع الحروف العربية بشكل صحيح في الـ Indexing
  static int indexAt(String s, int i) => s.codeUnitAt(i);

}