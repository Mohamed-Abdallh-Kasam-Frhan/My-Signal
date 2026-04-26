import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/providers/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mysignal/views/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final lightCustomColors = AppColorsExtension(
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

  final darkCustomColors = AppColorsExtension(
    glassColor: Colors.black.withOpacity(0.4),
    glassBorder: Colors.white.withOpacity(0.1),
    mainTextColor: Colors.white,
    subTextColor: Colors.white70,
    // new fields tuned for dark mode
    primaryTextColor: Colors.white,
    secondaryTextColor: Colors.white70,
    hintTextColor: Colors.white60,
    iconColor: Colors.white70,
    backgroundColor: const Color(0xFF0B1220),
    shadowColor: Colors.black,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      locale: const Locale('ar', 'SA'),

      // 2. إعدادات دعم الاتجاه من اليمين لليسار
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'), // العربية
      ],
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
        brightness: Brightness.light,
        extensions: [lightCustomColors],
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFAFAFAFA),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
        brightness: Brightness.dark,
        extensions: [darkCustomColors],
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          brightness: Brightness.dark,
        ),
        primaryColor: Colors.blueAccent,
        // تخصيص الألوان للوضع المظلم
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
