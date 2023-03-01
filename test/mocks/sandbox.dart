import 'package:flutter/material.dart';

class Sandbox extends StatelessWidget {
  final Widget testWidget;

  /// This widget creates a MaterialApp sandbox that isolates individual widgets for testing.
  const Sandbox({required this.testWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: testWidget,
    );
  }
}
