// ignore: must_be_immutable
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  Widget drawer;
  Widget page;

  PageLayout({required this.drawer, required this.page, super.key});

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constaints) {
        children = constaints.maxWidth > 768
            ? [Flexible(child: drawer), Expanded(child: page)]
            : [Expanded(child: page)];

        return Row(
          children: children,
        );
      },
    );
  }
}
