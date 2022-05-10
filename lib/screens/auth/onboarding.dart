import 'dart:async';

import 'package:client/styles/index.dart';
import 'package:flutter/material.dart';

Widget _buildBranding() {
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

  static const String id = "onboarding";

  _delay() {
    Timer(Duration(seconds: 5), () {
      // print("Debug: Functions runs ");
      // AuthNavigator.currentState.pushReplacementNamed(routeName);
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
            _buildBranding(),
          ],
        ),
      ),
    );
  }
}

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  static const String id = "onboarding";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBranding(),
          ],
        ),
      ),
    );
  }
}
