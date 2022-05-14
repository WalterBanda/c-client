import 'package:client/router/auth.dart';
import 'package:client/router/roles/roles.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:client/screens/auth/register.dart';
import 'package:client/screens/roles/change_roles.dart';

class GlobalRoutes {
  static const String auth = Auth.id;

  // TODO: Replace with Appropriate navigator/module id
  static const String roles = Roles.id;
}

class AuthRoutes {
  static const String splash = Splash.id;
  static const String onboarding = Onboarding.id;
  static const String login = Login.id;
  static const String register = Register.id;
}

class SharedRoutes {
  static const String settings = "settings";
  static const String profile = "profile";
}

class RoleRoutes {
  //TODO Implement Roles Routes
  static const String admin = "admin";
  static const String user = "user";
  static const String garage = "garage";
  static const String changeRole = ChangeRoleScreen.id;
  static const String requestRole = "request_role";
}
