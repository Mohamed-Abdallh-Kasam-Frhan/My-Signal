import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color? glassColor;
  final Color? glassBorder;
  final Color? mainTextColor;
  final Color? subTextColor;
  // New fields to improve dark mode consistency
  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Color? hintTextColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? shadowColor;

  AppColorsExtension({
    this.glassColor,
    this.glassBorder,
    this.mainTextColor,
    this.subTextColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.hintTextColor,
    this.iconColor,
    this.backgroundColor,
    this.shadowColor,
  });

  @override
  AppColorsExtension copyWith({
    Color? glassColor,
    Color? glassBorder,
    Color? mainTextColor,
    Color? subTextColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? hintTextColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? shadowColor,
  }) {
    return AppColorsExtension(
      glassColor: glassColor ?? this.glassColor,
      glassBorder: glassBorder ?? this.glassBorder,
      mainTextColor: mainTextColor ?? this.mainTextColor,
      subTextColor: subTextColor ?? this.subTextColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      glassColor: Color.lerp(glassColor, other.glassColor, t),
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t),
      mainTextColor: Color.lerp(mainTextColor, other.mainTextColor, t),
      subTextColor: Color.lerp(subTextColor, other.subTextColor, t),
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t),
      secondaryTextColor:
          Color.lerp(secondaryTextColor, other.secondaryTextColor, t),
      hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)
    );
  }

  static AppColorsExtension generateLiteModeColors(){
    return AppColorsExtension(
      glassColor: Colors.white.withOpacity(0.2),
      glassBorder: Colors.white.withOpacity(0.4),
      mainTextColor: const Color(0xFF1E293B),
      subTextColor: Colors.grey.shade600,
      // new fields for better dark/light consistency
      primaryTextColor: const Color(0xFF1E293B),
      secondaryTextColor: Colors.grey.shade600,
      hintTextColor: Colors.grey.shade400,
      iconColor: Colors.black54,
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
    );
  }

  static AppColorsExtension generateDarkModeColors(){
    return AppColorsExtension(
      glassColor: Colors.black.withOpacity(0.4),
      glassBorder: Colors.white.withOpacity(0.1),
      mainTextColor: Colors.white,
      subTextColor: Colors.white70,
      primaryTextColor: Colors.white,
      secondaryTextColor: Colors.white70,
      hintTextColor: Colors.white60,
      iconColor: Colors.white70,
      backgroundColor: const Color(0xFF0B1220),
      shadowColor: Colors.black,
    );
  }
}
