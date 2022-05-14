import 'package:client/router/auth.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:client/screens/auth/register.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class GlobalNavigator {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GlobalRoutes.auth:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Auth());
      // TODO: Write other Routes
      case GlobalRoutes.pages:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Auth());
      case GlobalRoutes.roles:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Auth());
      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Auth());
    }
  }

  static String initialRoute() {
    // TODO: Implement Auto Login into Application
    return GlobalRoutes.auth;
  }
}

class AuthRouter {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static const initialRoute = AuthRoutes.splash;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRoutes.splash:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Splash());
      case AuthRoutes.onboarding:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Onboarding());
      case AuthRoutes.login:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Login());
      case AuthRoutes.register:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Register());
      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Splash());
    }
  }
}

class PageRouter {
  static GlobalKey<NavigatorState> router = GlobalKey();
}
