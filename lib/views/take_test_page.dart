import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/models/question_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TakeTestPage extends StatefulWidget {
  const TakeTestPage({super.key});

  @override
  State<TakeTestPage> createState() => _TakeTestPageState();
}

class _TakeTestPageState extends State<TakeTestPage> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  List<int> _hiddenOptions = []; // لتخزين أرقام الخيارات المحذوفة عند التلميح
  bool _hintUsed = false;

  // بيانات تجريبية (يجب جلبها من الـ Controller لاحقاً)
  final List<QuestionModel> _questions = [
    QuestionModel(
      signImagePath: 'images/apple.png',
      correctAnswerIndex: 0,
      options: [
        Option(imagePath: 'images/apple.png', label: "تفاحة"),
        Option(imagePath: 'images/orange.png', label: "برتقالة"),
        Option(imagePath: 'images/banana.png', label: "موز"),
        Option(imagePath: 'images/pomegranate.png', label: "رمان"),
      ],
    ),
  ];

  void _useHint() {
    if (_hintUsed) return;

    final correctIndex = _questions[_currentQuestionIndex].correctAnswerIndex;
    List<int> incorrectIndices = [0, 1, 2, 3]..remove(correctIndex);

    // اختيار خيارين خاطئين عشوائياً لحذفهما
    incorrectIndices.shuffle();
    setState(() {
      _hiddenOptions = [incorrectIndices[0], incorrectIndices[1]];
      _hintUsed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildTestAppBar(context, customColors),
      body: Stack(
        children: [
          Container(color: Theme.of(context).scaffoldBackgroundColor),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // 1. صورة السؤال (الإشارة)
                  _buildSignContainer(question.signImagePath, customColors),

                  const SizedBox(height: 30),
                  Text("ماذا تعني هذه الإشارة؟",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: customColors.mainTextColor)),

                  const SizedBox(height: 20),

                  // 2. شبكة الخيارات
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return _buildOptionCard(
                            index, question.options[index], customColors);
                      },
                    ),
                  ),

                  // 3. أزرار التحكم
                  _buildActionButtons(customColors),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // حاوية صورة الإشارة بتصميم زجاجي
  Widget _buildSignContainer(
      String imagePath, AppColorsExtension customColors) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: customColors.glassColor,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: customColors.glassBorder!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(imagePath, fit: BoxFit.contain), // صورة الإشارة
      ),
    );
  }

  // بطاقة الخيار مع دعم الحذف السلس
  Widget _buildOptionCard(
      int index, Option option, AppColorsExtension customColors) {
    bool isHidden = _hiddenOptions.contains(index);
    bool isSelected = _selectedOptionIndex == index;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isHidden ? 0.0 : 1.0, // تلاشي الخيار المحذوف
      child: IgnorePointer(
        ignoring: isHidden,
        child: GestureDetector(
          onTap: () => setState(() => _selectedOptionIndex = index),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                  : customColors.glassColor,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : customColors.glassBorder!,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(option.imagePath, fit: BoxFit.contain),
                  ),
                ),
                Text(
                  option.label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : customColors.mainTextColor,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // أزرار التلميح والاعتماد
  Widget _buildActionButtons(AppColorsExtension customColors) {
    return Row(
      children: [
        // زر التلميح (50/50)
        Container(
          decoration: BoxDecoration(
            color: _hintUsed
                ? Colors.grey.withOpacity(0.1)
                : Colors.orange.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(PhosphorIconsFill.magicWand,
                color: _hintUsed ? Colors.grey : Colors.orange),
            onPressed: _hintUsed ? null : _useHint,
            tooltip: "حذف خيارين",
          ),
        ),
        const SizedBox(width: 15),
        // زر الاعتماد
        Expanded(
          child: ElevatedButton(
            onPressed: _selectedOptionIndex == null
                ? null
                : () {
                    // منطق الانتقال للسؤال التالي
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              // height: 55,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            child: const Text("تأكيد الإجابة",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildTestAppBar(
      BuildContext context, AppColorsExtension customColors) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const BackButton(),
      title: Column(
        children: [
          const Text("اختبار الحروف", style: TextStyle(fontSize: 16)),
          Text("سؤال ${_currentQuestionIndex + 1} من 10",
              style: TextStyle(fontSize: 12, color: customColors.subTextColor)),
        ],
      ),
      centerTitle: true,
    );
  }
}
