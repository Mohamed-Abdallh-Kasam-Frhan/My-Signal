import 'package:flutter/material.dart';
import 'package:mysignal/app_router.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/providers/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

  final lightCustomColors = AppColorsExtension.generateLiteModeColors();

  final darkCustomColors = AppColorsExtension.generateDarkModeColors();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
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
      routerConfig: goRouter,
    );
  }
}
