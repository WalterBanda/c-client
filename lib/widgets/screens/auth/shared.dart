import 'package:flutter/material.dart';

import '../../../styles/icons/chapchap.dart';

class Logo extends StatelessWidget {
  /// This widget displays the branding with consists of the logo and brand text
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Icon(ChapChap.logo, size: 160),
        SizedBox(height: 18),
        Text(
          "ChapChap",
          style: TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
