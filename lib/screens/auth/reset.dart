import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
  static const String id = "onboarding";

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.cyan, child: const Text(ResetPasswordScreen.id));
  }
}
