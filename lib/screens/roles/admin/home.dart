import 'package:flutter/material.dart';

import '../../../router/roles.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  static const String id = "admin";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Admin Home 🏠",
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
