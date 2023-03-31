import 'package:client/router/routers/auth/router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRouter.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AuthRouter(),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curveTween = CurveTween(curve: Curves.decelerate);
            Tween opacity = Tween(begin: 1, end: 0);
            return FadeTransition(
              opacity: animation.drive(opacity).drive(curveTween),
              child: child,
            );
          },
        );
      default:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AuthRouter());
    }
  }
}
