import 'package:flutter/material.dart';
import 'package:mysignal/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("الإعدادات"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // كرت الوضع المظلم
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      themeProvider.isDarkMode
                          ? PhosphorIconsFill.moon
                          : PhosphorIconsFill.sun,
                      color: themeProvider.isDarkMode
                          ? Colors.amber
                          : Colors.orange,
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "الوضع المظلم",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Switch.adaptive(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                  activeColor: Colors.blueAccent,
                ),
              ],
            ),
          ),

          // يمكنك إضافة خيارات أخرى هنا (تغيير الخط، اللغة، إلخ)
        ],
      ),
    );
  }
}
