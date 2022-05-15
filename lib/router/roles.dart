import 'package:client/core/routes/router.dart';
import 'package:flutter/material.dart';

class RoleNavigator extends StatelessWidget {
  const RoleNavigator({Key? key}) : super(key: key);

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
