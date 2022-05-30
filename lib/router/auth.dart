import 'package:flutter/material.dart';

import '../core/routes/router.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

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
