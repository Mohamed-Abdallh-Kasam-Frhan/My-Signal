import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/models/sign_model.dart';

class SignCard extends StatefulWidget {
  final SignModel sign;
  // أضفت خاصية لاسم التصنيف إذا لم تكن موجودة داخل الموديل مباشرة
  final String categoryName;

  const SignCard({
    super.key,
    required this.sign,
    this.categoryName = "عام", // قيمة افتراضية
  });

  @override
  State<SignCard> createState() => _SignCardState();
}

class _SignCardState extends State<SignCard> {
  bool isFavorite = false; // حالة المفضلة (مؤقتة هنا)

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppColorsExtension>()!.backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: widget.sign.color.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // 1. مساحة الصورة
            Container(
              width: 105,
              decoration: BoxDecoration(
                color: widget.sign.color.withOpacity(0.1),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(24),
                  topStart: Radius.circular(24),
                ),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(24)),
                child: Image.asset(
                  widget.sign.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported, color: widget.sign.color),
                ),
              ),
            ),

            // 2. المحتوى النصي
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // العنوان
                        Text(
                          widget.sign.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .extension<AppColorsExtension>()!
                                .primaryTextColor,
                          ),
                        ),
                        // زر المفضلة القابل للنقر
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            // هنا يمكنك إضافة منطق الحفظ في قاعدة البيانات
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isFavorite
                                  ? Theme.of(context)
                                      .colorScheme
                                      .error
                                      .withOpacity(0.1)
                                  : Theme.of(context)
                                      .extension<AppColorsExtension>()!
                                      .backgroundColor!
                                      .withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // الوصف
                    Text(
                      widget.sign.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context)
                            .extension<AppColorsExtension>()!
                            .secondaryTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // 3. اسم التصنيف 
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: widget.sign.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.category_outlined,
                              size: 14, color: widget.sign.color),
                          const SizedBox(width: 6),
                          Text(
                            widget.categoryName,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: widget.sign.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
