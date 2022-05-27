import 'package:flutter/material.dart';

import '../../../router/roles.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  static const String id = "user";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "User Home 🏠",
              style: TextStyle(
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
