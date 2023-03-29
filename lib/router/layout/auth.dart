import 'package:client/design/chapchap_icons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
/// Responsible for building layout for screens under Auth module
class AuthLayout extends StatelessWidget {
  Widget illustration;
  Widget page;

  /// Builds layouts for auth, it accepts [illustration] and [page] with constitues
  ///
  ///   - `pages`: Contains the current screen contents, changes minimaly between tablet and mobile
  ///   - `illustration`: This it the rive animation that would be shown in context of the current screen.
  AuthLayout({required this.illustration, required this.page, super.key});

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constaints) {
        children = constaints.maxWidth > 768
            ? [
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(ChapChap.logo, size: 50),
                        Expanded(child: Center(child: illustration)),
                      ],
                    )),
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
