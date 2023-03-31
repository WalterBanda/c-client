import 'package:client/router/routers/auth/router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRouter.id:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AuthRouter());
      default:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AuthRouter());
    }
  }
}
