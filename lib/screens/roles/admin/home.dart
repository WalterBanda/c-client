import 'package:flutter/material.dart';

import '../../../router/roles.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  static const String id = "admin";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(vertical: 130, horizontal: 30),
      maintainBottomViewPadding: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            "Admin Home 🏠 dskfjksdfgksjfksdkfjksdfjskjdfksjdkfjksjdfkjskdjfkjskdjfksjdkfjskdjfksdj",
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
    );
  }
}
