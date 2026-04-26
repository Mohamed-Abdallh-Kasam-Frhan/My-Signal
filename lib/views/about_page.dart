import 'package:flutter/material.dart';
import 'package:mysignal/widgets/info_page_layout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoPageLayout(
      title: "عن التطبيق",
      child: Column(
        children: [
          Image.asset('images/logoApp.png', width: 100, height: 100),
          const SizedBox(height: 20),
          const Text(
            "إشارَتي",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            "تطبيق إشارَتي هو جسر تواصل يهدف إلى تسهيل تعلم لغة الإشارة العربية وتوفير مرجع شامل للمصطلحات الإشارية لكل المهتمين بالتواصل مع فئة الصم والبكم.",
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.6, fontSize: 16),
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),
          const Text("تابعنا على منصات التواصل",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _socialIcon(PhosphorIconsFill.youtubeLogo, Colors.red,
                  "https://youtube.com/@asem"),
              _socialIcon(PhosphorIconsFill.twitterLogo, Colors.blue,
                  "https://twitter.com/asem"),
              _socialIcon(PhosphorIconsFill.githubLogo, Colors.black,
                  "https://github.com/asem"),
              _socialIcon(PhosphorIconsFill.facebookLogo, Colors.blueAccent,
                  "https://facebook.com"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color, String url) {
    return IconButton(
      icon: Icon(icon, color: color, size: 32),
      onPressed: () async {
        final uri = Uri.parse(url);
        try {
          await launchUrl(uri);
        } catch (e) {
          // Optionally show a snackbar or handle the error
        }
      },
    );
  }
}
