import 'package:client/core/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/user.dart';
import '../../core/routes/router.dart';
import '../../core/routes/routes.dart';
import '../../router/roles.dart';
import '../../styles/icons/chap_chap_icons.dart';
import '../../styles/ui/colors.dart';

class SwitchRoles extends StatelessWidget {
  const SwitchRoles({Key? key}) : super(key: key);

  static const String id = "switch_roles";

  void _navToRole(Roles role) {
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
        route = PagesRoutes.user;
    }

    GlobalNavigator.router.currentState!
        .pushReplacementNamed(PageNavigator.id, arguments: route);
  }

  IconData _getRoleIcon(Roles role) {
    switch (role) {
      case Roles.admin:
        return ChapChap.admin;
      case Roles.user:
        return ChapChap.user;
      case Roles.garage:
        return ChapChap.car;
      default:
        return ChapChap.info;
    }
  }

  Widget _generateRoles(BuildContext context) {
    // TODO Add get roles from user profile
    // final Future<List<String>> getRoles = Future<List<String>>.delayed(
    //   const Duration(milliseconds: 100),
    //   (() => ["admin", "user", "garage"]),
    // );

    // return FutureBuilder(
    //   future: getRoles,
    //   builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
    //     List<Widget> children = [];

    //     if (snapshot.hasData) {
    //       children.add(const SizedBox(width: 15));
    //       for (var i = 0; i < snapshot.data!.length; ++i) {
    //         children.add(
    //           _roleTab(
    //             onPressed: () => _navToRole(snapshot.data![i].toString()),
    //             icon: _getRoleIcon(snapshot.data![i].toString()),
    //           ),
    //         );
    //         children.add(const SizedBox(width: 15));
    //       }
    //     } else if (snapshot.hasError) {
    //       children.add(const Text("Unable to fetch your Roles"));
    //     } else {
    //       children.add(const Text("Fetching Roles"));
    //     }

    //     return Row(mainAxisSize: MainAxisSize.min, children: children);
    //   },
    // );

    return ListView.builder(
      itemCount: Provider.of<UserProvider>(context).user.roles.length,
      itemBuilder: (BuildContext context, int index) {
        return _roleTab(
          onPressed: () => _navToRole(
              Provider.of<UserProvider>(context).user.roles.elementAt(index)),
          icon: _getRoleIcon(
              Provider.of<UserProvider>(context).user.roles.elementAt(index)),
        );
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
              _generateRoles(context),
            ],
          ),
        ),
      ),
    );
  }
}
