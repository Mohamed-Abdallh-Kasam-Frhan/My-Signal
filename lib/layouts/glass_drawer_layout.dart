import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/views/about_page.dart';
import 'package:mysignal/views/disclaimer_page.dart';
import 'package:mysignal/views/privacy_policy.dart';
import 'package:mysignal/widgets/info_page_layout.dart';
import 'package:mysignal/views/settings_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GlassDrawerLayout extends StatelessWidget {
  const GlassDrawerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Drawer(
      // 1. يجب أن تكون خلفية الـ Drawer شفافة تماماً لرؤية الفلتر
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          // 2. طبقة الضبابية (Blur) التي تصنع تأثير الزجاج
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // قوة الضبابية
                  child: Container(
                decoration: BoxDecoration(
                  // لون أبيض شفاف جداً (يعمل كطبقة زجاجية)
                  color: customColors.glassColor?.withOpacity(0.15) ?? Colors.white.withOpacity(0.15),
                  border: Border(
                    // خط جانبي نحيف لتعزيز مظهر حافة الزجاج
                    left: BorderSide(
                        color: customColors.glassBorder?.withOpacity(0.3) ?? Colors.white.withOpacity(0.3), width: 1.5),
                  ),
                ),
              ),
            ),
          ),

          // 3. محتويات القائمة (تبقى فوق الزجاج)
          SafeArea(
                child: Column(
              children: [
                _buildDrawerHeader(context: context),
                Divider(indent: 20, endIndent: 20, color: customColors.glassColor?.withOpacity(0.24) ?? Colors.white24),
                _buildDrawerItem(
                  context: context,
                  icon: PhosphorIconsRegular.gear,
                  label: "الإعدادات",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: PhosphorIconsRegular.info,
                  label: "عن التطبيق",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AboutAppPage(),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: PhosphorIconsRegular.shieldCheck,
                  label: "سياسة الخصوصية",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: PhosphorIconsRegular.warningCircle,
                  label: "إخلاء المسؤولية",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DisclaimerPage(),
                      ),
                    );
                  },
                ),
                const Spacer(),
                _buildAdminSection(context: context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة بناء العناصر مع نص أبيض أو رمادي غامق يتناسب مع الزجاج
  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required BuildContext context
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).extension<AppColorsExtension>()!.primaryTextColor, size: 24),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).extension<AppColorsExtension>()!.primaryTextColor,
        ),
      ),
      onTap: onTap,
    );
  }

  //Header و Admin Section.. (بقية الدوال كما هي ولكن تأكد من استخدام ألوان شفافة)
  Widget _buildDrawerHeader({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Image.asset('images/logoApp.png', width: 80, height: 80),
          const SizedBox(height: 15),
          Text("إشارَتي",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Theme.of(context).extension<AppColorsExtension>()!.primaryTextColor)),
        ],
      ),
    );
  }

  Widget _buildAdminSection({required BuildContext context}) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.15), // زجاجي ذهبي-ish from colorScheme
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: customColors.glassBorder?.withOpacity(0.2) ?? Colors.white.withOpacity(0.2)),
      ),
      child: const Row(
        children: [
          Icon(PhosphorIconsRegular.crown, color: Colors.amber),
          SizedBox(width: 10),
          Text("للمشرف فقط", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
