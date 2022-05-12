import 'package:client/router/auth.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/onboarding.dart';

class GlobalRoutes {
  static const String auth = Auth.id;

  // TODO: Replace with Appropriate navigator/module id
  static const String pages = 'pages';
  static const String roles = 'roles';
}

class AuthRoutes {
  static const String splash = Splash.id;
  static const String onboarding = Onboarding.id;
  static const String login = Login.id;
  static const String register = "register";
}

class PageRoutes {}

class RoleRoutes {}
