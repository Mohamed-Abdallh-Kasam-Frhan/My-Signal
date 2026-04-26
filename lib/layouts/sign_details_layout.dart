import 'package:flutter/material.dart';
import 'package:mysignal/models/sign_model.dart';

class SignDetailsLayout extends StatelessWidget {
  final SignModel sign;
  final VoidCallback? onNext; // دالة للانتقال للتالي
  final VoidCallback? onPrevious; // دالة للانتقال للسابق

  const SignDetailsLayout(
      {super.key, required this.sign, this.onNext, this.onPrevious});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [sign.color.withOpacity(0.15), Colors.white, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 110, 20, 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. عرض الوسائط (طريقة التنفيذ)
                  _buildMediaSection(context),

                  const SizedBox(height: 20),

                  // 2. صف العنوان مع صورة الشيء وأزرار التفاعل
                  _buildHeaderRow(),

                  const SizedBox(height: 25),

                  // 3. خطوات التنفيذ
                  _buildExecutionSteps(),

                  const SizedBox(height: 25),

                  // 4. وصف مطول
                  _buildDeafConceptSection(),
                ],
              ),
            ),

            // 5. شريط التنقل السفلي الثابت (السابق والتالي)
            _buildNavigationDock(),
          ],
        ),
      ),
    );
  }

  // --- صف العنوان: يجمع الاسم، الصورة، وأيقونات التفاعل ---
  Widget _buildHeaderRow() {
    return Row(
      children: [
        // صورة الشيء الصغيرة (مثل التفاحة) للتعرف البصري
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(sign.image, fit: BoxFit.contain), // صورة التفاحة
          ),
        ),
        const SizedBox(width: 15),
        // اسم الإشارة
        Expanded(
          child: Text(
            sign.title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF2D2D2D)),
          ),
        ),
        // أزرار التفاعل (أيقونات فقط لتجنب التداخل)
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined, color: Colors.blueGrey)),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_rounded,
                color: Colors.redAccent)),
      ],
    );
  }

  // --- شريط التنقل (السابق / التالي) ---
  Widget _buildNavigationDock() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(
            bottom: 100, left: 30, right: 30), // مرفوع عن BottomNav
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navButton(
              Icons.arrow_back_ios_new_rounded,
              "التالي",
              onNext,
              isNext: true,
            ),
            Container(
              width: 1,
              height: 30,
              color: Colors.grey.withOpacity(0.2),
            ),
            _navButton(
              Icons.arrow_forward_ios_rounded,
              "السابق",
              onPrevious,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, String label, VoidCallback? onTap,
      {bool isNext = false}) {
    return TextButton.icon(
      iconAlignment: isNext ? IconAlignment.start : IconAlignment.end,
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 18,
        color: onTap != null ? sign.color : Colors.grey,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: onTap != null ? Colors.black87 : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // (بقية الدوال: _buildMediaSection, _buildExecutionSteps, _buildDeafConceptSection تبقى كما هي)
  Widget _buildMediaSection(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: sign.color.withOpacity(0.1), blurRadius: 20)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(sign.mediaHowTodo,
            fit: BoxFit.contain), // فيديو/صورة التنفيذ
      ),
    );
  }

  Widget _buildExecutionSteps() {
    List<String> steps = sign.execution.split('.');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("خطوات الإشارة:",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: sign.color, fontSize: 16)),
        const SizedBox(height: 10),
        ...steps.where((s) => s.trim().isNotEmpty).map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: sign.color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(step.trim()),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildDeafConceptSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Text(
        sign.description,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
          height: 1.5,
        ),
      ),
    );
  }
}
