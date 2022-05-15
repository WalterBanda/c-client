import 'package:client/core/routes/router.dart';
import 'package:flutter/material.dart';

class AdminNavigator extends StatelessWidget {
  const AdminNavigator({Key? key}) : super(key: key);

  static const String id = "roles_manager";

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AdminRouter.router,
      initialRoute: AdminRouter.initialRoute,
      onGenerateRoute: AdminRouter.generateRoute,
    );
  }
}
