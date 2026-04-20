import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const CustomAppBar({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 100,
      elevation: 10,
      backgroundColor: Colors.white,
     shadowColor: Colors.black,
      title:
       Text(
        title,style: TextStyle(fontSize: 30),
        textDirection: TextDirection.rtl,     
      ),
      actions: actions,
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
