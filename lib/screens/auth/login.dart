import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String id = "login";

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.amber, child: const Text(LoginScreen.id));
  }
}
