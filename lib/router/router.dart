import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 🏘️ Local imports
import '../screens/auth/resetPassword.dart';
import '../screens/shared/about.dart';
import 'navigator/auth.dart';
import 'navigator/roles.dart';
import '../../screens/auth/login.dart';
import '../../screens/auth/onboarding.dart';
import '../../screens/auth/register.dart';
import '../../screens/roles/admin/home.dart';
import '../../screens/roles/garage/home.dart';
import '../../screens/roles/switch_roles.dart';
import '../../screens/roles/user/home.dart';
import '../../screens/shared/profile.dart';
import '../../screens/shared/settings.dart';
import 'routes.dart';

class GlobalNavigator {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GlobalRoutes.auth:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AuthNavigator());
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
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AuthNavigator());
    }
  }

  static String initialRoute() {
    if (FirebaseAuth.instance.currentUser == null) {
      return GlobalRoutes.auth;
    } else {
      return GlobalRoutes.switchRoles;
    }
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
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Login());
      case AuthRoutes.register:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Register());
      case AuthRoutes.resetPassword:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ResetPassword());
      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const Splash());
    }
  }
}

class PageRouter {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static const initialRoute = PagesRoutes.user;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page = const UserHome();

    switch (settings.name) {
      case PagesRoutes.requestRole:
        page = const UserHome();
        break;
      case PagesRoutes.admin:
        page = const AdminHome();
        break;
      case PagesRoutes.garage:
        page = const GarageHome();
        break;
      case PagesRoutes.user:
        page = const UserHome();
        break;
      case SharedRoutes.profile:
        page = ProfilePage();
        break;
      case SharedRoutes.settings:
        page = const SettingsPage();
        break;
      case SharedRoutes.about:
        page = const AboutPage();
        break;

      default:
        page = const UserHome();
        break;
    }

    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}
