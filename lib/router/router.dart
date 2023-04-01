import 'package:flutter/material.dart';

import 'routers/page/router.dart';
import 'routers/auth/router.dart';
import '../animation/router.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const AuthRouter());

      case AppRoutes.pages:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const PageRouter());

      default:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const AuthRouter());
    }
  }
}

class AppRoutes {
  static const String auth = AuthRouter.id;
  static const String pages = PageRouter.id;
}
