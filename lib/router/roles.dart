import 'package:client/core/routes/router.dart';
import 'package:client/core/routes/routes.dart';
import 'package:client/styles/icons/chap_chap_icons.dart';
import 'package:client/styles/ui/colors.dart';
import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {
  const PageNavigator({
    ///* Auto Navigates to a given Page
    this.routeToNavigate = PageRouter.initialRoute,
    Key? key,
  }) : super(key: key);

  final String routeToNavigate;

  static const String id = "roles_manager";
  static GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PageNavigator.scaffold,
      drawer: customDrawer(),
      body: Stack(
        children: <Widget>[
          Navigator(
            key: PageRouter.router,
            initialRoute: routeToNavigate,
            onGenerateRoute: PageRouter.generateRoute,
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: AppColors.bg,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        scaffold.currentState!.openDrawer();
                      },
                      icon: const Icon(ChapChap.menu)),
                  const Text(
                    "Home",
                    // PageRouter.router.currentContext.
                    style: TextStyle(
                      fontFamily: "SF Pro Rounded",
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(ChapChap.light))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer customDrawer() {
    return Drawer(
      width: 270,
      child: Center(),
    );
  }
}
