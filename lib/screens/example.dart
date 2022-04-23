import 'package:flutter/material.dart';

import '../styles/index.dart';

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              ChapChap.logo,
              size: 100,
            ),
            SizedBox(height: 20),
            Text("Hello"),
          ],
        ),
      ),
    );
  }
}
