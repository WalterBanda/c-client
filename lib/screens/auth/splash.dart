import 'dart:async';

import 'package:flutter/material.dart';

import '../../router/router.dart';
import '../../router/routes.dart';
import '../../widgets/screens/auth/shared.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  static const String id = "splash";

  void _delay() {
    Timer(const Duration(seconds: 3), () {
      AuthRouter.router.currentState!
          .pushReplacementNamed(AuthRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    _delay();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Logo(),
          ],
        ),
      ),
    );
  }
}
