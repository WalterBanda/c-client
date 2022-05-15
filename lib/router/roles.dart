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
          const PageAppBar(),
        ],
      ),
    );
  }

  Drawer customDrawer() {
    void _userLogout() {
      // TODO Implement Logout
      GlobalNavigator.router.currentState!
          .pushReplacementNamed(GlobalRoutes.auth);
    }

    ElevatedButton _logoutButton(void _logout()) {
      return ElevatedButton(
        onPressed: _logout,
        style: ElevatedButton.styleFrom(
          primary: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          "Logout",
          style: TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Drawer(
      width: 270,
      child: Center(
        child: SizedBox(
          width: 230,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              navLink(),
              const SizedBox(height: 15),
              navLink(),
              const SizedBox(height: 15),
              navLink(),
              const SizedBox(height: 15),
              navLink(),
              const SizedBox(height: 15),
              navLink(),
              const SizedBox(height: 40),
              _logoutButton(_userLogout),
            ],
          ),
        ),
      ),
    );
  }

  Widget navLink({IconData? icon = ChapChap.info}) {
    return TextButton(
      onPressed: () {},
      // style: TextButton.styleFrom(
      //   primary: AppColors.primary,
      // ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return Colors.amber;
            }
            if (states.contains(MaterialState.hovered)) {
              return AppColors.bg;
            }
            return AppColors.primary;
          },
        ),
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        // surfaceTintColor: MaterialStateProperty.all<Color>(AppColors.success),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          const Text(
            "Home",
            style: const TextStyle(
              fontFamily: "SF Pro Rounded",
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}

class PageAppBar extends StatelessWidget {
  const PageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  PageNavigator.scaffold.currentState!.openDrawer();
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
    );
  }
}
