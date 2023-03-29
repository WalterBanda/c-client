import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const String id = "onboarding";

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue, child: const Text(OnboardingScreen.id));
  }
}
