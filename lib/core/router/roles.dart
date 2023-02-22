import 'package:client/core/providers/appdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user.dart';
import '../routes/router.dart';
import '../routes/routes.dart';
import '../../styles/icons/chap_chap_icons.dart';
import '../../styles/ui/colors.dart';

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
      drawer: customDrawer(context),
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

  Drawer customDrawer(BuildContext context) {
    Widget logoutButton() {
      return SizedBox(
        height: kIsWeb ? 50 : null,
        child: ElevatedButton(
          onPressed: () => Provider.of<UserProvider>(context, listen: false)
              .signOut(context),
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
        ),
      );
    }

    Widget profile() {
      return GestureDetector(
        onTap: () => PageRouter.router.currentState!
            .pushReplacementNamed(SharedRoutes.profile),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              minRadius: 30,
              maxRadius: 60,
              backgroundColor: AppColors.input.withOpacity(0.7),
              backgroundImage: NetworkImage(
                Provider.of<UserProvider>(context).user.profilePhoto,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Provider.of<UserProvider>(context).user.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      );
    }

    buildRoles(BuildContext context) {
      void navToRole(Roles role) {
        String route;

        switch (role) {
          case Roles.admin:
            route = PagesRoutes.admin;
            break;
          case Roles.user:
            route = PagesRoutes.user;
            break;
          case Roles.garage:
            route = PagesRoutes.garage;
            break;
          default:
            route = SharedRoutes.profile;
        }

        Provider.of<AppData>(context, listen: false).changeRoute(route);
        PageRouter.router.currentState!.pushReplacementNamed(route);
      }

      IconData getRoleIcon(Roles role) {
        switch (role) {
          case Roles.admin:
            return ChapChap.admin;
          case Roles.user:
            return ChapChap.home;
          case Roles.garage:
            return ChapChap.car;
          default:
            return ChapChap.info;
        }
      }

      String getLabel(Roles role) {
        switch (role) {
          case Roles.admin:
            return "Admin";
          case Roles.user:
            return "Home";
          case Roles.garage:
            return "Garage";
          default:
            return "User ⚠";
        }
      }

      try {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: Provider.of<UserProvider>(context)
              .user
              .roles
              .map((role) => navLink(
                    onPressed: () => navToRole(role),
                    icon: getRoleIcon(role),
                    label: getLabel(role),
                  ))
              .toList(),
        );
      } catch (e) {
        return navLink(
            icon: ChapChap.home,
            label: "Home ⚠",
            onPressed: () {
              Provider.of<AppData>(context, listen: false)
                  .changeRoute(SharedRoutes.about);
              PageRouter.router.currentState!
                  .pushReplacementNamed(SharedRoutes.profile);
            });
      }
    }

    return Drawer(
      width: 270,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            profile(),
            const SizedBox(height: 40),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRoles(context),
                  navLink(
                    icon: ChapChap.user,
                    label: "Profile",
                    onPressed: () {
                      Provider.of<AppData>(context, listen: false)
                          .changeRoute(SharedRoutes.profile);
                      PageRouter.router.currentState!
                          .pushReplacementNamed(SharedRoutes.profile);
                    },
                  ),
                  navLink(
                    icon: Icons.settings,
                    label: "Settings",
                    onPressed: () {
                      Provider.of<AppData>(context, listen: false)
                          .changeRoute(SharedRoutes.settings);
                      PageRouter.router.currentState!
                          .pushReplacementNamed(SharedRoutes.settings);
                    },
                  ),
                  navLink(
                    icon: ChapChap.info,
                    label: "About",
                    onPressed: () {
                      Provider.of<AppData>(context, listen: false)
                          .changeRoute(SharedRoutes.about);
                      PageRouter.router.currentState!
                          .pushReplacementNamed(SharedRoutes.about);
                    },
                  ),
                ]),
            const SizedBox(height: 40),
            logoutButton(),
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
            Text(
              Provider.of<AppData>(context).currentRoute,
              style: const TextStyle(
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
