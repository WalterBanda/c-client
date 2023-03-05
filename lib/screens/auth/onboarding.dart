import 'package:client/core/models/user.dart';
import 'package:client/core/providers/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../router/router.dart';
import '../../router/routes.dart';
// 🏘️ Local imports
import '../../styles/icons/chapchap.dart';
import '../../styles/ui/colors.dart';
import '../../widgets/screens/auth/shared.dart';

SnackBar alertSnackBar({
  String? message,
  String? errorLabel,
  VoidCallback? errorCallback,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: AppColors.bgDark,
    action: errorLabel != null
        ? SnackBarAction(
            label: errorLabel,
            onPressed: errorCallback ?? () {},
          )
        : null,
    content: Text(
      message ?? "Enter Your Message",
      style: const TextStyle(
        fontSize: 18,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  static const String id = "onboarding";

  void _googleSignIn(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false)
        .authUser(context: context, signInMethods: SignInMethods.google);
  }

  void _gitHubSignIn(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false)
        .authUser(context: context, signInMethods: SignInMethods.github);
  }

  void _emailSignIn() =>
      AuthRouter.router.currentState!.pushReplacementNamed(AuthRoutes.login);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Logo(),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Authlet(
                      onPressed: () => _googleSignIn(context),
                      icon: const Icon(ChapChap.google, size: 40)),
                  const SizedBox(width: 15),
                  Authlet(
                      onPressed: () => _gitHubSignIn(context),
                      icon: const Icon(ChapChap.github, size: 40)),
                  const SizedBox(width: 15),
                  Authlet(
                      onPressed: _emailSignIn,
                      icon: const Icon(ChapChap.login, size: 40)),
                ],
              ),
              const SizedBox(height: 20),
              const CreateAccountShortcut(),
            ],
          ),
        ),
      ),
    );
  }
}
