import 'package:client/core/models/roles/constants.dart';
import 'package:client/core/routes/router.dart';
import 'package:client/core/routes/routes.dart';
import 'package:client/router/roles/roles.dart';
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

Row generateRoles() {
  void _roleNavigation(RoleTypes role) {
    String route;

    switch (role) {
      case RoleTypes.admin:
        route = RoleRoutes.admin;
        break;
      case RoleTypes.user:
        route = RoleRoutes.user;
        break;
      case RoleTypes.garage:
        route = RoleRoutes.garage;
        break;
      default:
        route = RoleRoutes.user;
    }

    RolesRouter.router.currentState!.pushReplacementNamed(RoleRoutes.user);
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      role(onPressed: () => _roleNavigation, icon: ChapChap.admin),
      const SizedBox(width: 15),
      role(onPressed: () => _roleNavigation, icon: ChapChap.user),
      const SizedBox(width: 15),
      role(onPressed: () => _roleNavigation, icon: ChapChap.garage),
    ],
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
