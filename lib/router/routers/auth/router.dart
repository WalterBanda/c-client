import 'package:flutter/material.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  static const id = 'auth';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Route: $id"),
        Placeholder(),
      ],
    );
  }
}
