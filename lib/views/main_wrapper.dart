import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysignal/layouts/blurred_bottom_nav.dart';
import 'package:mysignal/layouts/glass_drawer_layout.dart';
import 'package:mysignal/layouts/modern_app_bar.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // السطر السحري: هذا السطر يجعل Flutter يراقب الـ URL الحالي.
    // بمجرد أن يتغير الـ URL (سواء بـ push أو pop)، سيعاد تنفيذ هذه الدالة.
    final GoRouterState state = GoRouterState.of(context);

    return Scaffold(
      drawer: const GlassDrawerLayout(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      // نمرر الـ key لضمان أن الـ AppBar يشعر بالتغيير
      appBar: ModernAppBar(
        key: ValueKey(state.uri.toString()),
        navigationShell: navigationShell,
      ),
      body: navigationShell,
      bottomNavigationBar: BlurredBottomNav(context: context, widget: this),
    );
  }
}
