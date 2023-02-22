import 'package:flutter/material.dart';

import '../routes/router.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  static const String id = "auth";

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AuthRouter.router,
      initialRoute: AuthRouter.initialRoute,
      onGenerateRoute: AuthRouter.generateRoute,
    );
  }
}
