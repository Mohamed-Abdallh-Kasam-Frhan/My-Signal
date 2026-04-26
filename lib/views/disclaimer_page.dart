import 'package:flutter/material.dart';
import 'package:mysignal/widgets/info_page_layout.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPageLayout(
      title: "إخلاء المسؤولية",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange),
              SizedBox(width: 10),
              Text("تنبيه هام",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 15),
          Text(
            "إن المحتوى المقدم في تطبيق 'إشارَتي' مخصص للأغراض التعليمية والتثقيفية فقط. "
            "على الرغم من حرصنا على دقة الإشارات وتوافقها مع القواميس المعتمدة، إلا أن لغة الإشارة قد تختلف باختلاف المناطق واللهجات المحلية. "
            "التطبيق لا يتحمل مسؤولية أي سوء فهم ناتج عن استخدام الإشارات في سياقات غير مخصصة لها.",
            style: TextStyle(height: 1.8, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
