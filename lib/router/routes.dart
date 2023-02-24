
// 🏘️ Local imports
import '../screens/auth/resetPassword.dart';
import 'navigator/auth.dart';
import 'navigator/roles.dart';
import '../../screens/auth/login.dart';
import '../../screens/auth/onboarding.dart';
import '../../screens/auth/register.dart';
import '../../screens/roles/admin/home.dart';
import '../../screens/roles/garage/home.dart';
import '../../screens/roles/switch_roles.dart';
import '../../screens/roles/user/home.dart';

class GlobalRoutes {
  static const String auth = AuthNavigator.id;

  static const String pages = PageNavigator.id;
  static const String switchRoles = SwitchRoles.id;
}

class AuthRoutes {
  static const String splash = Splash.id;
  static const String onboarding = Onboarding.id;
  static const String login = Login.id;
  static const String register = Register.id;
  static const String resetPassword = ResetPassword.id;
}

class SharedRoutes {
  static const String settings = "settings";
  static const String profile = "profile";
  static const String about = "about";
}

class PagesRoutes {
  static const String admin = AdminHome.id;
  static const String user = UserHome.id;
  static const String garage = GarageHome.id;
  static const String requestRole = "request_role";
}
