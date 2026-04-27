import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'dart:math' as Math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late AnimationController _pulseController;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();

    // متحكم النبض: يكرر نفسه ذهاباً وإياباً
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _shadowAnimation = Tween<double>(begin: 40.0, end: 100.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutCubic),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // الانتقال بعد 4 ثوانٍ لإعطاء وقت لحركة النقاط
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        context.go('/home?title=التصنيفات'); // نمرر العنوان في الرابط
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFAFAFAFA), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),

            // منطقة الشعار
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // استخدام AnimatedBuilder لجعل الظل ينبض
                  AnimatedBuilder(
                    animation: _shadowAnimation,
                    builder: (context, child) {
                      return Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: customColors.backgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              // لون النبض يصبح أقوى وأضعف مع الحركة
                              color: Theme.of(context).colorScheme.primary.withOpacity(
                                  0.15 - (_shadowAnimation.value / 1000)),
                              blurRadius: _shadowAnimation
                                  .value, // القيمة المتغيرة للنبض
                              spreadRadius:
                                  _shadowAnimation.value / 5, // انتشار الظل
                              offset: const Offset(0,
                                  0), // اجعله في المنتصف ليكون توهجاً دائرياً
                            ),
                          ],
                        ),
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'images/logoApp.png',
                      width: 140,
                      height: 140,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "إشارَتي",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: customColors.primaryTextColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 2),

            // مؤشر التحميل العصري (نقاط متحركة)
            const ModernDotLoading(),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

// ويدجت النقاط المتحركة العصرية
class ModernDotLoading extends StatefulWidget {
  const ModernDotLoading({super.key});

  @override
  State<ModernDotLoading> createState() => _ModernDotLoadingState();
}

class _ModernDotLoadingState extends State<ModernDotLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _dotController;

  @override
  void initState() {
    super.initState();
    _dotController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat(); // تكرار الحركة باستمرار
  }

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dotController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            // حساب التأخير لكل نقطة لعمل موجة
            double delay = index * 0.2;
            double value = (Math.sin((_dotController.value * 2 * Math.pi) -
                        (delay * Math.pi))) *
                    0.5 +
                0.5;

            final accent = Theme.of(context).colorScheme.primary;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.2 + (value * 0.8)),
                shape: BoxShape.circle,
              ),
              // تحريك النقاط للأعلى وللأسفل قليلاً
              transform: Matrix4.translationValues(0, -value * 8, 0),
            );
          }),
        );
      },
    );
  }
}
