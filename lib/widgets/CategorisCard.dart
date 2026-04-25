import 'package:flutter/material.dart';
 import 'package:mysignal/models/Categoris.dart';

class CategoryCard extends StatefulWidget {
  final Category element;
  const CategoryCard({super.key, required this.element});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 110,
            decoration: const BoxDecoration(
              color: Color(0xFAFAFAFA),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Icon(
                widget.element.icon,
                size: 100,
                color: widget.element.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.element.title,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                if (widget.element.numberOf > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${(widget.element.numberOf * 100).toInt()}%"),
                      const SizedBox(width: 5),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
