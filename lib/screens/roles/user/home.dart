import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  static const String id = "user";

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text("User Home 🏠"),
      ),
    );
  }
}
