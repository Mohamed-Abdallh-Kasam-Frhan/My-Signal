import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/views/main_wrapper.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BlurredBottomNav extends StatelessWidget {
  const BlurredBottomNav({
    super.key,
    required this.context,
    required this.widget,
  });

  final BuildContext context;
  final MainWrapper widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 80,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                            .extension<AppColorsExtension>()!
                            .glassColor
                            ?.withOpacity(0.3) ??
                        Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Theme.of(context)
                              .extension<AppColorsExtension>()!
                              .glassBorder
                              ?.withOpacity(0.3) ??
                          Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              BottomNavigationBar(
                currentIndex: widget.navigationShell.currentIndex,
                onTap: (index) {
                  widget.navigationShell.goBranch(index);
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Theme.of(context)
                    .extension<AppColorsExtension>()!
                    .iconColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedFontSize: 16,
                unselectedFontSize: 12,
                selectedIconTheme: const IconThemeData(size: 35),
                unselectedIconTheme: const IconThemeData(size: 30),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.house),
                    label: "الرئيسية",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.heart), // غير محدد (مفرغ)
                    label: "المفضلات",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.question),
                    label: "إختبار",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
