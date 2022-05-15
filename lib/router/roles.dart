import 'package:client/core/routes/router.dart';
import 'package:client/core/routes/routes.dart';
import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {
  const PageNavigator({
    ///* Auto Navigates to a given Page
    this.routeToNavigate = PageRouter.initialRoute,
    Key? key,
  }) : super(key: key);

  final String routeToNavigate;

  static const String id = "roles_manager";

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: PageRouter.router,
      initialRoute: routeToNavigate,
      onGenerateRoute: PageRouter.generateRoute,
    );
  }
}
