enum TestStatus { notStarted, inProgress, failed, passed }

class TestModel {
  final String title;
  final TestStatus status;
  final double? score; // من 100
  final int totalQuestions;
  final int answeredQuestions;

  TestModel({
    required this.title,
    required this.status,
    this.score,
    required this.totalQuestions,
    this.answeredQuestions = 0,
  });

  // تحديد التقدير بناءً على الدرجة
  String get rating {
    if (score == null) return "";
    if (score! >= 90) return "ممتاز";
    if (score! >= 75) return "جيد جداً";
    if (score! >= 50) return "ناجح";
    return "راسب";
  }
}
