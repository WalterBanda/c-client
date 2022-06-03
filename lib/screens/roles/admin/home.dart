import 'package:client/core/routes/router.dart';
import 'package:client/screens/roles/user/home.dart';
import 'package:client/styles/ui/colors.dart';
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
                        builder: (context) => const SearchOverlay(),
                      ),
                    ),
                    buildAddItem(
                      context: context,
                      label: "+ Add Admin",
                      onPressed: () => showDialog(
                        context: context,
                        useRootNavigator: false,
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
              children: [
                const Text(
                  "User Verification Requests",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 27),
                Expanded(
                  child: TabbedLayout(
                    tabLabel: ["Garage Requests", "Admin Requests"],
                    tabs: [
                      const Center(child: Text("Tab 🎌")),
                      const Center(child: Text("Tab ☕")),
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

class TabbedLayout extends StatelessWidget {
  TabbedLayout({
    Key? key,
    required this.tabLabel,
    required this.tabs,
  }) : super(key: key);

  final List<String> tabLabel;
  final List<Widget> tabs;

  static GlobalKey<NavigatorState> tabNav = GlobalKey();
  static Key firstTab = Key("1");
  static Key secondTab = Key("2");

  Widget _getTab({index}) {
    return tabs.elementAt(index);
  }

  bool _getSelectedTab(String index) {
    if (tabNav.currentWidget?.key != null &&
        tabNav.currentWidget!.key == firstTab) {
      return true;
    } else if (tabNav.currentWidget?.key != null &&
        tabNav.currentWidget!.key == firstTab) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromRGBO(0, 0, 0, 0.037),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tab(
                label: tabLabel[0],
                selected: _getSelectedTab("1"),
                onPressed: () {
                  tabNav.currentState!.pushReplacementNamed("1");
                },
                index: firstTab,
              ),
              _tab(
                label: tabLabel[1],
                selected: _getSelectedTab("2"),
                onPressed: () {
                  tabNav.currentState!.pushReplacementNamed("2");
                },
                index: secondTab,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: Navigator(
            key: tabNav,
            initialRoute: "1",
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case "1":
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        _getTab(index: tabs.length - 2),
                    transitionDuration: const Duration(milliseconds: 0),
                  );
                case "2":
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        _getTab(index: tabs.length - 1),
                    transitionDuration: const Duration(milliseconds: 0),
                  );
                default:
                  return PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        const Center(child: Text("Tab 🎌")),
                    transitionDuration: const Duration(milliseconds: 0),
                  );
              }
            },
          ),
        )
      ],
    );
  }

  Widget _tab({
    bool selected = false,
    required String label,
    required onPressed,
    required index,
  }) =>
      TextButton(
        key: index,
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          primary: selected ? AppColors.success : Color(0x42000000),
          backgroundColor: selected ? AppColors.bgDark : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}

Widget buildAddItem(
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
