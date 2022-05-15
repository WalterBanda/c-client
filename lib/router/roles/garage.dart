import 'package:client/core/routes/router.dart';
import 'package:flutter/material.dart';

class GarageNavigator extends StatelessWidget {
  const GarageNavigator({Key? key}) : super(key: key);

  static const String id = "roles_manager";

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: GarageRouter.router,
      initialRoute: GarageRouter.initialRoute,
      onGenerateRoute: GarageRouter.generateRoute,
    );
  }
}
