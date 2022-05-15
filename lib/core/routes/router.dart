import 'package:client/router/auth.dart';
import 'package:client/router/roles.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:client/screens/auth/register.dart';
import 'package:client/screens/roles/admin/home.dart';
import 'package:client/screens/roles/switch_roles.dart';
import 'package:client/screens/roles/garage/home.dart';
import 'package:client/screens/roles/user/home.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class GlobalNavigator {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GlobalRoutes.auth:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Auth());
      // TODO: Implement Auto Login for Roles
      case GlobalRoutes.pages:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => PageNavigator(
            routeToNavigate: settings.arguments as String,
          ),
        );
      case GlobalRoutes.switchRoles:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const SwitchRoles());
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

  static const initialRoute = PagesRoutes.user;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // TODO Implement Routes
    switch (settings.name) {
      case PagesRoutes.requestRole:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const UserHome());
      case PagesRoutes.admin:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const AdminHome());
      case PagesRoutes.garage:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const GarageHome());
      case PagesRoutes.user:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const UserHome());
      case SharedRoutes.profile:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const UserHome());
      case SharedRoutes.settings:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const UserHome());

      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const UserHome());
    }
  }
}
