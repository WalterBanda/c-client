import 'package:client/core/routes/router.dart';
import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {
  const PageNavigator({Key? key}) : super(key: key);

  static const String id = "roles_manager";

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: PageRouter.router,
      initialRoute: PageRouter.initialRoute,
      onGenerateRoute: PageRouter.generateRoute,
    );
  }
}
