import 'package:flutter/material.dart';
import 'package:mysignal/model/Categoris.dart';
import 'package:mysignal/widgets/CategorisCard.dart';
import 'package:mysignal/widgets/appBar.dart';
import 'package:mysignal/widgets/CoustomBottomNavigation.dart';


class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "التصنيفات",
        actions: [
          Icon(Icons.search),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        color: Color(0xFAFAFAFA),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return Categoriscard(item: item);
            },
          ),
        ),
      ),
      bottomNavigationBar: const Coustombottomnavigation(selectElemnt: 3),
    );
  }
}
