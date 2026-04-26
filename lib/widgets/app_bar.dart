import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;
    return AppBar(
      centerTitle: true,
      toolbarHeight: 100,
      elevation: 10,
      backgroundColor: customColors.backgroundColor,
      shadowColor: customColors.shadowColor,
      title: Text(
        title,
        style: TextStyle(fontSize: 30, color: customColors.primaryTextColor),
        textDirection: TextDirection.rtl,
      ),
      actions: actions,
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
