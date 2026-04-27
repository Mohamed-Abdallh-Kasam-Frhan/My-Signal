import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysignal/layouts/categories_layout.dart';
import 'package:mysignal/layouts/favorite_layout.dart';
import 'package:mysignal/layouts/exam_categories_layout.dart';
import 'package:mysignal/layouts/signs_layout.dart';
import 'package:mysignal/layouts/sign_details_layout.dart';
import 'package:mysignal/models/exam_category.dart';
import 'package:mysignal/views/category_tests_page.dart';
import 'package:mysignal/views/main_wrapper.dart';
import 'package:mysignal/views/search_page.dart';
import 'package:mysignal/views/splash_page.dart';
import 'package:mysignal/views/take_test_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _favoriteNavigatorKey = GlobalKey<NavigatorState>();
final _examNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    // صفحة السبلاش خارج إطار التنقل السفلي
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // صفحة البحث (كامل الشاشة)
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchPage(),
    ),

    // إعداد التنقل المتداخل للتبويبات
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainWrapper(navigationShell: navigationShell);
      },
      branches: [
        // فرع الرئيسية مع مساراته الفرعية
        // داخل تعريف الـ branches في GoRouter
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const CategoriesLayout(),
              routes: [
                GoRoute(
                  path: 'signs/:categoryId', // هنا نحدد الباراميتر
                  builder: (context, state) {
                    return SignsLayout(
                      categoryId:
                          int.tryParse(state.pathParameters['categoryId']!) ??
                              0,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'details/:signId', // باراميتر لصفحة التفاصيل
                      builder: (context, state) {
                        return SignDetailsLayout(
                          signId:
                              int.tryParse(state.pathParameters['signId']!) ??
                                  0,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // فرع المفضلة
        StatefulShellBranch(
          navigatorKey: _favoriteNavigatorKey,
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoriteLayout();
              },
            ),
          ],
        ),

        // فرع الاختبارات
        StatefulShellBranch(
          navigatorKey: _examNavigatorKey,
          routes: [
            GoRoute(
              path: '/exams',
              builder: (context, state) => const ExamCategoriesLayout(),
              routes: [
                GoRoute(
                  path:
                      '/category/:categoryId', // مسار فرعي لصفحة الاختبارات حسب التصنيف
                  builder: (context, state) {
                    return CategoryTestsPage(
                      category: ExamCategory(
                        title: "عنوان تجريبي", // يمكنك استبداله ببيانات حقيقية
                        icon: Icons.category,
                        color: Colors.blue,
                        totalExams: 5,
                        progress: 0.5,
                        categoryId:
                            int.tryParse(state.pathParameters['categoryId']!) ??
                                0,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/exams/take/:examId', // مسار لبدء الاختبار
      builder: (context, state) {
        ScaffoldMessenger.of(context).activate();
        // هنا يمكنك بناء صفحة الاختبار بناءً على examId
        return const TakeTestPage();
      },
    ),
  ],
);
