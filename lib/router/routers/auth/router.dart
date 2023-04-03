import 'package:client/animation/router.dart';
import 'package:client/router/utils/route_parser.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:client/screens/auth/register.dart';
import 'package:client/screens/auth/reset.dart';
import 'package:flutter/material.dart';

class AuthRouter extends StatelessWidget {
  AuthRouter({super.key});

  RouterDelegate<RouteSettings> _delegate = _Delegate();
  RouteInformationParser<RouteSettings> _parser = _Parser();

  static const id = 'auth';

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: _delegate,
      routeInformationParser: _parser,
    );
  }
}

class AuthRoutes {
  static const String onboarding = OnboardingScreen.id;
  static const String login = LoginScreen.id;
  static const String register = RegisterScreen.id;
  static const String resetPassword = ResetPasswordScreen.id;
}

class _PageState {}

class _Parser extends RouteInformationParser<RouteSettings> {
  @override

  /// Parses Url into Route setting, ` responsible for creating the respective page`
  Future<RouteSettings> parseRouteInformation(
      RouteInformation routeInformation) async {
    return RouteSettings(name: routeInformation.location!.basePath);
  }

  @override

  /// Handles route details from delegate and updates the OS - Browser path
  RouteInformation? restoreRouteInformation(RouteSettings configuration) {}
}

class _PageBuilder extends Page<_PageState> {
  Widget child;

  _PageBuilder({
    required this.child,
    super.name,
  }) : super(key: ValueKey(name), restorationId: name);

  @override
  Route<_PageState> createRoute(BuildContext context) {
    return PageRouteBuilder(
      transitionDuration: RouterAnimations.duration,
      transitionsBuilder: RouterAnimations.fade,
      pageBuilder: (ctx, __, _) => child,
    );
  }
}

class _Delegate extends RouterDelegate<RouteSettings>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey();

  @override

  ///
  Future<void> setNewRoutePath(RouteSettings configuration) async {}

  @override

  /// Restores routing from app state
  RouteSettings? get currentConfiguration => super.currentConfiguration;

  @override

  /// Logic for removing route of stack
  Future<bool> popRoute() {
    return super.popRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        _PageBuilder(
            name: AuthRoutes.onboarding, child: const OnboardingScreen()),
        _PageBuilder(name: AuthRoutes.register, child: const RegisterScreen()),
        _PageBuilder(name: AuthRoutes.login, child: const LoginScreen()),
        _PageBuilder(
            name: AuthRoutes.resetPassword, child: const ResetPasswordScreen()),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
