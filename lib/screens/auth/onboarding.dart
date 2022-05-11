import 'dart:async';

import 'package:client/styles/index.dart';
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
            // const SizedBox(height: 30),
            // const CircularProgressIndicator(
            //   color: Colors.black,
            // )
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
    return Container();
  }

  _googleSignIn() {}

  _facebookSignIn() {}

  _emailSignIn() {}

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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Authlet(_googleSignIn, const Icon(ChapChap.google)),
                const SizedBox(width: 15),
                Authlet(_facebookSignIn, const Icon(ChapChap.facebook)),
                const SizedBox(width: 15),
                Authlet(_emailSignIn, const Icon(ChapChap.email)),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
