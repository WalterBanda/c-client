import 'dart:async';

import 'package:client/styles/index.dart';
import 'package:client/styles/ui/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/route/router.dart';
import '../../core/route/routes.dart';

Widget _buildBranding(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
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

  _delay() {
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
            _buildBranding(context),
          ],
        ),
      ),
    );
  }
}

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  static const String id = "onboarding";

  Widget Authlet(GestureTapCallback onPressed, Widget icon) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        elevation: 0,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: icon,
    );
  }

  _googleSignIn() {}

  _facebookSignIn() {}

  _emailSignIn() => AuthRouter.router.currentState!.pushNamed(AuthRoutes.login);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBranding(context),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Authlet(_googleSignIn, const Icon(ChapChap.google, size: 36)),
                // const SizedBox(width: 15),
                Authlet(
                    _facebookSignIn,
                    const Icon(
                      ChapChap.facebook,
                      size: 36,
                      color: Colors.blue,
                    )),
                // const SizedBox(width: 15),
                Authlet(_emailSignIn, const Icon(ChapChap.email, size: 36)),
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
      onPressed: () =>
          AuthRouter.router.currentState!.pushNamed(AuthRoutes.register),
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
