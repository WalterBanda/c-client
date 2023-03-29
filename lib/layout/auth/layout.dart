import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthLayout extends StatelessWidget {
  Widget illustration;
  Widget navigator;

  AuthLayout({required this.illustration, required this.navigator, super.key});

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constaints) {
        children = constaints.maxWidth > 768
            ? [
                Expanded(flex: 3, child: illustration),
                Expanded(flex: 2, child: navigator)
              ]
            : [Expanded(flex: 2, child: navigator)];

        return Row(
          children: children,
        );
      },
    );
  }
}
