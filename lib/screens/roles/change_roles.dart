import 'package:client/core/routes/router.dart';
import 'package:client/core/routes/routes.dart';
import 'package:client/router/roles.dart';
import 'package:flutter/material.dart';

import '../../styles/index.dart';
import '../../styles/ui/colors.dart';

class ChangeRoleScreen extends StatelessWidget {
  const ChangeRoleScreen({Key? key}) : super(key: key);

  static const String id = "change_roles";

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
              generateRoles(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget generateRoles() {
  void _navToRole(String role) {
    String route;

    switch (role) {
      case RoleRoutes.admin:
        route = RoleRoutes.admin;
        break;
      case RoleRoutes.user:
        route = RoleRoutes.user;
        break;
      case RoleRoutes.garage:
        route = RoleRoutes.garage;
        break;
      default:
        route = RoleRoutes.user;
    }

    RolesRouter.router.currentState!.pushReplacementNamed(route);
  }

  IconData _getIcon(String role) {
    switch (role) {
      case RoleRoutes.admin:
        return ChapChap.admin;
      case RoleRoutes.user:
        return ChapChap.user;
      case RoleRoutes.garage:
        return ChapChap.garage;
      default:
        return ChapChap.user;
    }
  }

  // TODO Add get roles from user profile
  final Future<List<String>> _dataFetch = Future<List<String>>.delayed(
    const Duration(milliseconds: 100),
    (() => ["admin", "user", "garage"]),
  );

  return FutureBuilder(
    future: _dataFetch,
    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      List<Widget> children = [];

      if (snapshot.hasData) {
        children.add(const SizedBox(width: 15));
        for (var i = 0; i < snapshot.data!.length; ++i) {
          children.add(role(
              onPressed: () => _navToRole(snapshot.data![i].toString()),
              icon: _getIcon(snapshot.data![i].toString())));
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

Widget role({required GestureTapCallback onPressed, IconData? icon}) {
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
