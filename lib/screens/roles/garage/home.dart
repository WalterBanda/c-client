import 'package:client/styles/ui/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../router/roles.dart';
import '../admin/home.dart';
import '../user/home.dart';

class GarageHome extends StatelessWidget {
  const GarageHome({Key? key}) : super(key: key);

  static const String id = "garage";

  Widget _buildStats({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    required double cummulative,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // elevation: 1,
          primary: AppColors.bgDark,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SvgPicture.asset(
                  cummulative.isNegative
                      ? "assets/images/res/graph_down.svg"
                      : "assets/images/res/graph_up.svg",
                  height: 15.2,
                  width: 39.82,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 130, left: 36, right: 36),
      maintainBottomViewPadding: false,
      child: Center(
        child: ConstrainedBox(
          constraints: pageConstraints,
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
                      "Earnings Stats",
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
                          label: "Daily",
                          cummulative: -5.23,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => const SearchOverlay(),
                          ),
                        ),
                        SizedBox(width: 10),
                        _buildStats(
                          context: context,
                          label: "Weekly",
                          cummulative: 39.69,
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
        ),
      ),
    );
  }
}
