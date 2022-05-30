import 'package:flutter/material.dart';

import '../../core/routes/router.dart';
import '../../core/routes/routes.dart';
import '../../router/roles.dart';
import '../../styles/index.dart';
import '../../styles/ui/colors.dart';

class SwitchRoles extends StatelessWidget {
  const SwitchRoles({Key? key}) : super(key: key);

  static const String id = "switch_roles";

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

    GlobalNavigator.router.currentState!
        .pushReplacementNamed(PageNavigator.id, arguments: route);
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case PagesRoutes.admin:
        return ChapChap.admin;
      case PagesRoutes.user:
        return ChapChap.user;
      case PagesRoutes.garage:
        return ChapChap.car;
      default:
        return ChapChap.info;
    }
  }

  Widget _generateRoles() {
    // TODO Add get roles from user profile
    final Future<List<String>> getRoles = Future<List<String>>.delayed(
      const Duration(milliseconds: 100),
      (() => ["admin", "user", "garage"]),
    );

    return FutureBuilder(
      future: getRoles,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        List<Widget> children = [];

        if (snapshot.hasData) {
          children.add(const SizedBox(width: 15));
          for (var i = 0; i < snapshot.data!.length; ++i) {
            children.add(
              _roleTab(
                onPressed: () => _navToRole(snapshot.data![i].toString()),
                icon: _getRoleIcon(snapshot.data![i].toString()),
              ),
            );
            children.add(const SizedBox(width: 15));
          }
        } else if (snapshot.hasError) {
          children.add(const Text("Unable to fetch your Roles"));
        } else {
          children.add(const Text("Fetching Roles"));
        }

        return Row(mainAxisSize: MainAxisSize.min, children: children);
      },
    );
  }

  Widget _roleTab({required GestureTapCallback onPressed, IconData? icon}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.bgDark,
        onSurface: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 19),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Icon(icon, size: 25, color: AppColors.primary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose which Role to log into",
                style: TextStyle(
                  fontFamily: "SF Pro Rounded",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              _generateRoles(),
            ],
          ),
        ),
      ),
    );
  }
}
