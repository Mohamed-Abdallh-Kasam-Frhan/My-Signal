import 'package:flutter/material.dart';
import 'package:mysignal/views/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.notoKufiArabic().fontFamily),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
