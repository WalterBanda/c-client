import 'package:client/animation/router/animations.dart';
import 'package:client/router/routers/auth/router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRouter.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AuthRouter(),
          transitionDuration: RouterAnimations.duration,
          transitionsBuilder: RouterAnimations.fade,
        );
      default:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AuthRouter());
    }
  }
}
