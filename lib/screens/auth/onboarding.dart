import 'dart:async';

import 'package:client/core/models/user.dart';
import 'package:client/core/providers/user.dart';
import 'package:provider/provider.dart';

import '../../styles/icons/chap_chap_icons.dart';
import '../../styles/ui/colors.dart';
import 'package:flutter/material.dart';

import '../../core/routes/router.dart';
import '../../core/routes/routes.dart';

Widget buildBranding(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: const <Widget>[
      Icon(ChapChap.logo, size: 100),
      SizedBox(height: 18),
      Text(
        "ChapChap",
        style: TextStyle(
          fontFamily: "SF Pro Rounded",
          fontSize: 36,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

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
          children: [
            buildBranding(context),
          ],
        ),
      ),
    );
  }
}

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

  Widget authLet(GestureTapCallback onPressed, Widget icon) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: icon,
    );
  }

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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                authLet(() => _googleSignIn(context),
                    const Icon(ChapChap.google, size: 36)),
                const SizedBox(width: 15),
                authLet(() => _gitHubSignIn(context),
                    const Icon(ChapChap.github, size: 36)),
                const SizedBox(width: 15),
                authLet(_emailSignIn, const Icon(ChapChap.email, size: 36)),
              ],
            ),
            const SizedBox(height: 20),
            createAccountShortcut(),
          ],
        ),
      ),
    );
  }
}

Container createAccountShortcut() {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: TextButton(
      onPressed: () => AuthRouter.router.currentState!
          .pushReplacementNamed(AuthRoutes.register),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Don’t have an Account ?  ",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Create Account",
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Color(0xff4285f4),
              color: AppColors.success,
              fontSize: 13,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}
