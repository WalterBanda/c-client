import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/routes/router.dart';
import '../core/routes/routes.dart';
import '../styles/icons/chap_chap_icons.dart';
import '../styles/index.dart';
import '../styles/ui/colors.dart';

BoxConstraints pageConstraints =
    const BoxConstraints(minWidth: 320, maxWidth: 480);

class PageNavigator extends StatelessWidget {
  PageNavigator({
    ///* Auto Navigates to a given Page
    this.routeToNavigate = PageRouter.initialRoute,
    Key? key,
  }) : super(key: key);

  final String routeToNavigate;

  static const String id = "roles_manager";
  static GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PageNavigator.scaffold,
      backgroundColor: AppColors.bgDark,
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
    Future<void> _userLogout() async {
      await firebaseAuth.signOut().then(
            (value) => GlobalNavigator.router.currentState!
                .pushReplacementNamed(GlobalRoutes.auth),
          );
    }

    ElevatedButton _logoutButton(VoidCallback logout) {
      return ElevatedButton(
        onPressed: logout,
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
          Text(
            firebaseAuth.currentUser!.displayName.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    }

    _buildRoles() {
      final Future<List<String>> getRoles = Future<List<String>>.delayed(
        const Duration(milliseconds: 100),
        (() => ["user", "admin", "garage"]),
      );

      void _navToRole(String role) {
        String route;

        switch (role) {
          case PagesRoutes.admin:
            route = PagesRoutes.admin;
            break;
          case PagesRoutes.user:
            route = PagesRoutes.user;
            break;
          case PagesRoutes.garage:
            route = PagesRoutes.garage;
            break;
          default:
            route = PagesRoutes.user;
        }

        PageRouter.router.currentState!.pushReplacementNamed(route);
      }

      IconData _getRoleIcon(String role) {
        switch (role) {
          case PagesRoutes.admin:
            return ChapChap.admin;
          case PagesRoutes.user:
            return ChapChap.home;
          case PagesRoutes.garage:
            return ChapChap.car;
          default:
            return ChapChap.info;
        }
      }

      String _getLabel(String role) {
        switch (role) {
          case PagesRoutes.admin:
            return "Admin";
          case PagesRoutes.user:
            return "Home";
          case PagesRoutes.garage:
            return "Garage";
          default:
            return "User ⚠";
        }
      }

      return FutureBuilder(
        future: getRoles,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          List<Widget> children = [];

          if (snapshot.hasError ||
              snapshot.hasData == false ||
              (snapshot.hasData && snapshot.data!.isEmpty)) {
            return navLink(
                icon: ChapChap.home,
                label: "Home ⚠",
                onPressed: () {
                  PageRouter.router.currentState!
                      .pushReplacementNamed(PagesRoutes.user);
                });
          }

          for (var i = 0; i < snapshot.data!.length; ++i) {
            children.add(
              navLink(
                onPressed: () => _navToRole(snapshot.data![i].toString()),
                icon: _getRoleIcon(snapshot.data![i].toString()),
                label: _getLabel(snapshot.data![i].toString()),
              ),
            );
          }

          return Column(mainAxisSize: MainAxisSize.min, children: children);
        },
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
                  _buildRoles(),
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
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
            borderRadius: BorderRadius.circular(20), color: AppColors.bgDark),
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
              // TODO Implement automatic headings
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
