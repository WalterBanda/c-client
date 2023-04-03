import 'package:client/screens/error/unknown.dart';
import 'package:flutter/material.dart';

import 'routers/page/router.dart';
import 'routers/auth/router.dart';
import '../animation/router.dart';
import 'utils/route_parser.dart';

class AppRouter {
  static GlobalKey<NavigatorState> router = GlobalKey();
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name?.basePath) {
      case AppRoutes.auth:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => AuthRouter());

      case AppRoutes.app:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const PageRouter());
    }
    return null;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return PageRouteBuilder(
        transitionDuration: RouterAnimations.duration,
        transitionsBuilder: RouterAnimations.fade,
        pageBuilder: (_, __, ___) => const UnknownScreen());
  }
}

class AppRoutes {
  static const String auth = AuthRouter.id;
  static const String app = PageRouter.id;
}
