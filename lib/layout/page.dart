// ignore: must_be_immutable
import 'package:flutter/material.dart';

// ignore: must_be_immutable
/// Responsible for building layout for screens
class PageLayout extends StatelessWidget {
  Widget drawer;
  Widget page;

  /// Builds layouts for auth, it accepts [illustration] and [page] with constitues
  ///
  ///   - `page`: Contains the current screen contents, changes minimaly between tablet and mobile
  ///   - `drawer`: Application drawer, its usually hidden in mobile and can only be shown by using the menu button.
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
