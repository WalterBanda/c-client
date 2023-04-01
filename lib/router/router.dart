import 'package:flutter/material.dart';

import 'routers/page/router.dart';
import 'routers/auth/router.dart';
import '../animation/router.dart';

class AppRouter {
  static GlobalKey<NavigatorState> router = GlobalKey();
  static RouterDelegate<RouteSettings> delegate = _Delegate();
  static RouteInformationParser<RouteSettings> parser = _Parser();
}

class AppRoutes {
  static const String auth = AuthRouter.id;
  static const String pages = PageRouter.id;
}

class _Parser extends RouteInformationParser<RouteSettings> {
  // Url to navigation state
  @override
  Future<RouteSettings> parseRouteInformation(
      RouteInformation routeInformation) async {
    return RouteSettings(name: routeInformation.location ?? '/');
  }

  // Navigation state to url
  @override
  RouteInformation restoreRouteInformation(RouteSettings navigationState) {
    return RouteInformation(location: '/${AppRoutes.auth}');
  }
}

class _Delegate extends RouterDelegate<RouteSettings>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteSettings> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: generateRoute,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const AuthRouter());

      case AppRoutes.pages:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const PageRouter());

      default:
        return PageRouteBuilder(
            transitionDuration: RouterAnimations.duration,
            transitionsBuilder: RouterAnimations.fade,
            pageBuilder: (_, __, ___) => const AuthRouter());
    }
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => AppRouter.router;

  // Navigation state to app state
  @override
  Future<void> setNewRoutePath(RouteSettings navigationState) async {}

  // App state to Navigation state, triggered by notifyListeners()
  @override
  RouteSettings get currentConfiguration => RouteSettings(name: '');
}
