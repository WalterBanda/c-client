import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthLayout extends StatelessWidget {
  Widget illustration;
  Widget page;

  AuthLayout({required this.illustration, required this.page, super.key});

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constaints) {
        children = constaints.maxWidth > 768
            ? [
                Expanded(flex: 3, child: illustration),
                Expanded(flex: 2, child: page)
              ]
            : [Expanded(flex: 2, child: page)];

        return Row(
          children: children,
        );
      },
    );
  }
}
