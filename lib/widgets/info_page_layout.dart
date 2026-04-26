import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';

class InfoPageLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const InfoPageLayout({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(title,
            style: TextStyle(
                color: customColors.mainTextColor,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: customColors.mainTextColor),
      ),
      body: Stack(
        children: [
          // خلفية بتدرج خفيف
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).primaryColor.withOpacity(0.05)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: customColors.glassColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: customColors.glassBorder!),
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
