class QuestionModel {
  final String signImagePath; // صورة الإشارة (السؤال)
  final List<Option> options;
  final int correctAnswerIndex;

  QuestionModel({
    required this.signImagePath,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class Option {
  final String imagePath;
  final String label;

  Option({required this.imagePath, required this.label});
}
