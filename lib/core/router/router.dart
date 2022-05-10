// GlobalKey<NavigatorState> AuthRouter = GlobalKey();
// GlobalKey<NavigatorState> PageRouter = GlobalKey();
import 'package:client/core/router/routes.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:flutter/material.dart';

class GlobalNavigator {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => Onboarding(),
    );
  }

  static String initialRoute() {
    // TODO: Implement Auto Login into Application
    return GlobalRoutes.auth;
  }
}
