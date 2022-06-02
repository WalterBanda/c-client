import 'package:client/screens/roles/user/home.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  static const String id = "admin";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 130, left: 36, right: 36),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildAddItem(
                      context: context,
                      label: "+ Add Garage",
                      onPressed: () => showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (context) => SearchOverlay(),
                      ),
                    ),
                    buildAddItem(
                      context: context,
                      label: "+ Add Admin",
                      onPressed: () => showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (context) => SearchOverlay(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User Verification Requests",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 27),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildAddItem(
    {required BuildContext context,
    required String label,
    required GestureTapCallback onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: DottedBorder(
      padding: EdgeInsets.all(30),
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      child: Text(
        label,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "SF Pro Rounded",
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
