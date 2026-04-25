import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 100,
      elevation: 10,
      backgroundColor: const Color(0xFAFAFAFA),
      shadowColor: Colors.black,
      title: Text(
        title,
        style: const TextStyle(fontSize: 30),
        textDirection: TextDirection.rtl,
      ),
      actions: actions,
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
