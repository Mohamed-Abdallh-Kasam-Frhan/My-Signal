import 'package:flutter/material.dart';
import 'package:mysignal/widgets/info_page_layout.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPageLayout(
      title: "سياسة الخصوصية",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("نحن نحترم خصوصيتك",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text(
            "• لا نقوم بجمع أي بيانات شخصية حساسة دون إذنك.\n"
            "• البيانات المخزنة في 'المفضلة' يتم حفظها محلياً على جهازك فقط.\n"
            "• نستخدم ملفات تعريف الارتباط فقط لتحسين تجربة المستخدم وتحليل أداء التطبيق.\n"
            "• لن نقوم بمشاركة بياناتك مع أي طرف ثالث لأغراض تسويقية.",
            style: TextStyle(height: 1.8, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
