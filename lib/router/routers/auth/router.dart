import 'package:client/router/utils/route_parser.dart';
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
      pages: [],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
