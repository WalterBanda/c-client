import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../router/roles.dart';
import '../admin/home.dart';
import '../user/home.dart';

class GarageHome extends StatelessWidget {
  const GarageHome({Key? key}) : super(key: key);

  static const String id = "garage";

  Widget _buildStats(
      {required BuildContext context,
      required String label,
      required GestureTapCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: DottedBorder(
        padding: const EdgeInsets.all(30),
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: Text(
          label,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

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
                  "Daily Stats",
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
                    _buildStats(
                      context: context,
                      label: "Daily Earnings",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const SearchOverlay(),
                      ),
                    ),
                    _buildStats(
                      context: context,
                      label: "Weekly Earnings",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const SearchOverlay(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Service Requests",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 27),
                Expanded(
                  child: TabbedLayout(
                    tabLabel: ["New Requests", "Uncompleted"],
                    tabs: [
                      Center(child: Text("Tab 1 🎌")),
                      Center(child: Text("Tab 2 ☕")),
                    ],
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
