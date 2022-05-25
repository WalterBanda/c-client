import 'package:client/core/routes/router.dart';
import 'package:client/core/routes/routes.dart';
import 'package:client/styles/icons/chap_chap_icons.dart';
import 'package:client/styles/index.dart';
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

    Widget _profile() {
      Widget _defaultProfile() {
        return Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.bg.withOpacity(0.2),
          ),
          child: const Icon(ChapChap.user, size: 50),
        );
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _defaultProfile(),
          const SizedBox(height: 20),
          const Text(
            "Username",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    }

    return Drawer(
      width: 270,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _profile(),
            const SizedBox(height: 40),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navLink(
                      icon: ChapChap.home,
                      label: "Home",
                      onPressed: () {
                        PageRouter.router.currentState!
                            .pushReplacementNamed(PagesRoutes.user);
                      }),
                  navLink(
                      icon: ChapChap.admin,
                      label: "Admin",
                      onPressed: () {
                        PageRouter.router.currentState!
                            .pushReplacementNamed(PagesRoutes.admin);
                      }),
                  navLink(
                      icon: ChapChap.car,
                      label: "Garage",
                      onPressed: () {
                        PageRouter.router.currentState!
                            .pushReplacementNamed(PagesRoutes.garage);
                      }),
                  navLink(
                      icon: ChapChap.user,
                      label: "Profile",
                      onPressed: () {
                        PageRouter.router.currentState!
                            .pushReplacementNamed(SharedRoutes.profile);
                      }),
                  navLink(
                      icon: Icons.settings,
                      label: "Settings",
                      onPressed: () {
                        PageRouter.router.currentState!
                            .pushReplacementNamed(SharedRoutes.settings);
                      }),
                ]),
            const SizedBox(height: 40),
            _logoutButton(_userLogout),
          ],
        ),
      ),
    );
  }

  Widget navLink({
    IconData? icon = ChapChap.info,
    String label = "Link",
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      style: TextButton.styleFrom(
        primary: AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        textStyle: const TextStyle(
          fontFamily: "SF Pro Rounded",
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      label: Text(label),
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
