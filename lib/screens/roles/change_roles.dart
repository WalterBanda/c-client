import 'package:client/core/routes/router.dart';
import 'package:client/core/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../styles/index.dart';
import '../../styles/ui/colors.dart';

class ChangeRoleScreen extends StatelessWidget {
  const ChangeRoleScreen({Key? key}) : super(key: key);

  static const String id = "change_roles";

  Widget role(GestureTapCallback onPressed, Widget icon) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: icon,
    );
  }

  _roleNavigation() {
    // TODO Implement Role based Login
    RolesRouter.router.currentState!.pushReplacementNamed(RoleRoutes.user);
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  role(_roleNavigation, const Icon(ChapChap.google, size: 36)),
                  const SizedBox(width: 15),
                  role(_roleNavigation, const Icon(ChapChap.github, size: 36)),
                  const SizedBox(width: 15),
                  role(_roleNavigation, const Icon(ChapChap.email, size: 36)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
