import 'package:flutter/material.dart';

class PageRouter extends StatelessWidget {
  const PageRouter({super.key});

  static const id = 'app';

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
