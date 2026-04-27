import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ModernAppBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // 1. الاستماع لتغيرات المسار (هذا السطر هو المحرك للتحديث التلقائي)
    final state = GoRouterState.of(context);
    final location = state.uri.path;
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;

    // 2. منطق العنوان: يقرأ من الرابط (Query) أو يعطي قيمة افتراضية
    String title =
        state.uri.queryParameters['title'] ?? _getDefaultTitle(location);

    // 3. منطق زر الرجوع: فحص المسار يدوياً لضمان الدقة
    bool isRoot =
        location == '/home' || location == '/favorites' || location == '/exams';
    bool canPop = !isRoot;

    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: customColors.glassColor?.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: customColors.glassBorder?.withOpacity(0.4) ??
                          Colors.white.withOpacity(0.4),
                      width: 1.5),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(canPop
                          ? Icons.arrow_back_ios_rounded
                          : Icons.notes_rounded),
                      onPressed: () {
                        if (canPop) {
                          context.pop();
                        } else {
                          Scaffold.of(context).openDrawer();
                        }
                      },
                    ),
                    Expanded(
                        child: Text(title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    IconButton(
                      icon: const Icon(PhosphorIconsRegular.magnifyingGlass),
                      onPressed: () => context.push('/search'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getDefaultTitle(String location) {
    if (location.startsWith('/favorites')) return "المفضلة";
    if (location.startsWith('/exams')) return "الاختبارات";
    return "التصنيفات";
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
