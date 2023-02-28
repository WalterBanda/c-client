import 'package:flutter/material.dart';

import '../../../styles/icons/chapchap.dart';

class Logo extends StatelessWidget {
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
