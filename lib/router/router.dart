import 'package:flutter/material.dart';

import 'routers/page/router.dart';
import 'routers/auth/router.dart';
import '../animation/router/animations.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRouter.id:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const AuthRouter());

      case PageRouter.id:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const AuthRouter());

      default:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const AuthRouter());
    }
  }
}
