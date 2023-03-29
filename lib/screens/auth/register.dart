import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String id = "register";

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.brown, child: const Text(RegisterScreen.id));
  }
}
