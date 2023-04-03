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
      pages: const [
        MaterialPage<_PageState>(key: ValueKey('login'), child: LoginScreen()),
        MaterialPage<_PageState>(
            key: ValueKey('register'), child: RegisterScreen()),
        MaterialPage<_PageState>(
            key: ValueKey('onboarding'), child: OnboardingScreen()),
        MaterialPage<_PageState>(
            key: ValueKey('reset'), child: ResetPasswordScreen()),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
