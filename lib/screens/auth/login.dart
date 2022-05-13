import 'package:client/core/route/router.dart';
import 'package:client/core/route/routes.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:client/styles/ui/colors.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String id = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primary,
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
            const SizedBox(height: 40),
            createAccountShortcut()
          ],
        ),
      ),
    );
  }
}
