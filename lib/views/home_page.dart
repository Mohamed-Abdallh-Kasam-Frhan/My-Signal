import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/app_colors_extension.dart';
import 'package:mysignal/layouts/exam_categories_layout.dart';
import 'package:mysignal/layouts/favorite_layout.dart';
import 'package:mysignal/layouts/glass_drawer_layout.dart';
import 'package:mysignal/layouts/home_layout.dart';
import 'package:mysignal/layouts/sign_details_layout.dart';
import 'package:mysignal/layouts/signs_layout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<NavigatorState> _homeNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  String appBarTitle = "التصنيفات";

  @override
  Widget build(BuildContext context) {
    String displayTitle;

    if (_selectedIndex == 1) {
      displayTitle = "المفضلة";
    } else if (_selectedIndex == 0) {
      displayTitle = appBarTitle;
    } else {
      displayTitle = "الاختبارات";
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: const GlassDrawerLayout(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: ModernAppBar(
          selectedIndex: _selectedIndex,
          homeNavigatorKey: _homeNavigatorKey,
          context: context,
          title: displayTitle),
      // داخل الـ Scaffold الخاص بك
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _homeNavigation(),
          const FavoriteLayout(),
          const ExamCategoriesLayout(),
        ],
      ),
      bottomNavigationBar: _buildBlurredBottomNav(),
    );
  }

  Navigator _homeNavigation() {
    return Navigator(
      key: _homeNavigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (innerContext) => HomeLayout(
            onCategoryTap: (category) {
              // --- المستوى الأول: من التصنيفات إلى الإشارات ---
              setState(() => appBarTitle = category.title);

              Navigator.of(innerContext)
                  .push(
                MaterialPageRoute(
                  builder: (context) => SignsLayout(
                    category: category,
                    onSignTap: (sign) {
                      // --- المستوى الثاني: من الإشارة إلى صفحة التفاصيل ---
                      setState(() => appBarTitle = sign.title);

                      Navigator.of(innerContext)
                          .push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SignDetailsLayout(sign: sign), // صفحة التفاصيل
                        ),
                      )
                          .then((_) {
                        // عند العودة من التفاصيل، نرجع عنوان التصنيف
                        setState(() => appBarTitle = category.title);
                      });
                    },
                  ),
                ),
              )
                  .then((_) {
                // عند العودة من الإشارات، نرجع لعنوان "التصنيفات" الرئيسي
                setState(() => appBarTitle = "التصنيفات");
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildBlurredBottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 80,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).extension<AppColorsExtension>()!.glassColor?.withOpacity(0.3) ?? Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Theme.of(context).extension<AppColorsExtension>()!.glassBorder?.withOpacity(0.3) ?? Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Theme.of(context).extension<AppColorsExtension>()!.iconColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedFontSize: 16,
                unselectedFontSize: 12,
                selectedIconTheme: const IconThemeData(size: 35),
                unselectedIconTheme: const IconThemeData(size: 30),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.house),
                    label: "الرئيسية",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.heart), // غير محدد (مفرغ)
                    label: "المفضلات",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(PhosphorIconsRegular.question),
                    label: "إختبار",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ModernAppBar({
    super.key,
    required int selectedIndex,
    required GlobalKey<NavigatorState> homeNavigatorKey,
    required this.context,
    required this.title,
  })  : _selectedIndex = selectedIndex,
        _homeNavigatorKey = homeNavigatorKey;

  final int _selectedIndex;
  final GlobalKey<NavigatorState> _homeNavigatorKey;
  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColorsExtension>()!;

    bool canPopInsideHome = _selectedIndex == 0 &&
      (_homeNavigatorKey.currentState?.canPop() ?? false);

    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: customColors.glassColor?.withOpacity(0.2) ?? Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: customColors.glassBorder?.withOpacity(0.4) ?? Colors.white.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          canPopInsideHome
                              ? Icons.arrow_back_ios_rounded
                              : Icons.notes_rounded,
                        ),
                        color: customColors.primaryTextColor,
                        onPressed: () {
                          if (canPopInsideHome) {
                            // الرجوع للخلف داخل النافيجيتور الداخلي للرئيسية
                            _homeNavigatorKey.currentState?.pop();
                          } else {
                            // هنا تضع منطق فتح الـ Drawer
                            Scaffold.of(context).openDrawer();
                          }
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: customColors.primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: customColors.backgroundColor?.withOpacity(0.05) ?? Colors.black.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            PhosphorIconsRegular.magnifyingGlass,
                            color: customColors.primaryTextColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
