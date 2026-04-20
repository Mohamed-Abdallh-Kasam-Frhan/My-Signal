import 'package:flutter/material.dart';
import 'package:mysignal/model/Categoris.dart';

class Categoriscard extends StatelessWidget {
  final Map<String, dynamic> item;
  const Categoriscard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xFAFAFAFA),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Icon(
                item["icon"] ?? Icons.category,
                size: 100,
                color: item["color"] ?? Colors.blue,
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
                  item["title"],
                  // textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                if (item["progress"] > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${(item["progress"] * 100).toInt()}%"),
                      const SizedBox(width: 5),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: item["progress"],
                          color: item["color"] ?? Colors.blue,
                          minHeight: 10,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
