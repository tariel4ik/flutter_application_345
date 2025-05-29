import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/sensors/presentation/pages/home.dart';


class AppRouter {
  static late GoRouter _router;
  static late GlobalKey<NavigatorState> _rootNavigatorKey;

  static GoRouter get router => _router;
  static BuildContext? get rootContext => _rootNavigatorKey.currentContext;

  static Future<void> initialize() async {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/home_page', //Pages.menu.pagePath,
      routes: [
        GoRoute(
          name: "home_page",
          path: "/home_page",
          pageBuilder: (_, home) {
            return CustomTransitionPage(
              key: home.pageKey,
              child: HomePage(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: CurveTween(
                    curve: Curves.easeInOutCirc,
                  ).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
      errorBuilder: (_, __) => HomePage(),
    );
  }
}
