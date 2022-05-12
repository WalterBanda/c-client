import 'package:client/core/route/router.dart';
import 'package:client/core/route/routes.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String id = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => AuthRouter.router.currentState!
              .popAndPushNamed(AuthRoutes.onboarding),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildBranding(context),
            const SizedBox(height: 40),
            const Text(
              "Login to your Account ",
              style: TextStyle(
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
