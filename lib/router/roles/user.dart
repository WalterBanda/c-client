import 'package:client/core/routes/router.dart';
import 'package:flutter/material.dart';

class UserNavigator extends StatelessWidget {
  const UserNavigator({Key? key}) : super(key: key);

  static const String id = "roles_manager";

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: UserRouter.router,
      initialRoute: UserRouter.initialRoute,
      onGenerateRoute: UserRouter.generateRoute,
    );
  }
}
