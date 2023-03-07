import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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

class ProviderSandbox extends StatelessWidget {
  final List<SingleChildWidget> providers;
  final Widget testWidget;

  const ProviderSandbox(
      {required this.providers, required this.testWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        home: testWidget,
      ),
    );
  }
}
