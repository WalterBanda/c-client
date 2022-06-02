import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  static const String id = "admin";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 130, left: 27, right: 27),
      maintainBottomViewPadding: false,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Admin Tasks",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [],
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.blue,
              child: const Text("skdkjsfjskdjf"),
            ),
          ),
        ],
      ),
    );
  }
}
