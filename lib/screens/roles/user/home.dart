import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../router/roles.dart';

class UserHome extends StatelessWidget {
  UserHome({this.name, Key? key}) : super(key: key);

  static const String id = "user";
  String? name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$name Home 🏠",
              style: const TextStyle(
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                PageNavigator.scaffold.currentState!.openDrawer();
              },
              child: const Text("Open Drawer"),
            )
          ],
        ),
      ),
    );
  }
}
