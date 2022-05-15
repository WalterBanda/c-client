import 'package:client/router/auth.dart';
import 'package:client/router/roles.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:client/screens/auth/register.dart';
import 'package:client/screens/roles/switch_roles.dart';
import 'package:client/screens/roles/user/home.dart';

import '../../screens/roles/admin/home.dart';
import '../../screens/roles/garage/home.dart';

class GlobalRoutes {
  static const String auth = Auth.id;

  // TODO: Replace with Appropriate navigator/module id
  static const String pages = PageNavigator.id;
  static const String switchRoles = SwitchRoles.id;
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

class PagesRoutes {
  static const String admin = AdminHome.id;
  static const String user = UserHome.id;
  static const String garage = GarageHome.id;
  static const String requestRole = "request_role";
}
