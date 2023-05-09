import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GlobalKey<NavigatorState> router = GlobalKey();
  static final config = GoRouter(navigatorKey: router,routes: []);
}
