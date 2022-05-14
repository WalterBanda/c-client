import 'package:client/core/route/router.dart';
import 'package:flutter/material.dart';

class Roles extends StatelessWidget {
  const Roles({Key? key}) : super(key: key);

  static const String id = "roles_manager";

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: RolesRouter.router,
      initialRoute: RolesRouter.initialRoute,
      onGenerateRoute: RolesRouter.generateRoute,
    );
  }
}
