import 'package:client/router/roles.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/styles/icons/chap_chap_icons.dart';
import 'package:client/styles/ui/colors.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: pageConstraints,
        child: Dialog(
          backgroundColor: AppColors.bgDark,
          insetPadding:
              const EdgeInsets.only(top: 24, bottom: 24, right: 10, left: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: SingleChildScrollView(child: child),
          ),
        ),
      ),
    );
  }
}

class AddAdmin extends StatelessWidget {
  const AddAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AddGarage extends StatelessWidget {
  const AddGarage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Garage",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 25),
          garageInfo(),
          const SizedBox(height: 25),
          garageDescription(),
          const SizedBox(height: 25),
          garageAddress(),
          const SizedBox(height: 25),
          garageAdminUser(),
        ],
      ),
    );
  }

  garageAdminUser() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Garage Admin User",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: const TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
          decoration: InputDecoration(
            hintText: "User responsible for the garage",
            filled: true,
            isCollapsed: true,
            prefixIcon: const Icon(ChapChap.user, size: 20),
            contentPadding:
                const EdgeInsets.only(top: 24, bottom: 24, left: 15, right: 10),
            fillColor: AppColors.input,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  garageAddress() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Garage Address",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: const TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
          decoration: InputDecoration(
            hintText: "Add your Address",
            filled: true,
            isCollapsed: true,
            suffixIcon: const Icon(ChapChap.location, size: 20),
            contentPadding:
                const EdgeInsets.only(top: 24, bottom: 24, left: 15),
            fillColor: AppColors.input,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  garageDescription() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Garage Description",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          minLines: 4,
          maxLines: 5,
          style: const TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
          decoration: InputDecoration(
            filled: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.fromLTRB(15, 20, 5, 20),
            fillColor: AppColors.input,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Row garageInfo() {
    getImage() {
      return Image.asset(
        'assets/images/img/garage.png',
        errorBuilder: (_, __, ___) {
          return const FlutterLogo(size: 78);
        },
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 84,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.bgDark,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.149),
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: getImage(),
            ),
            const SizedBox(height: 5),
            const Text(
              "Garage Image",
              style: TextStyle(
                color: Color.fromRGBO(106, 106, 106, 1),
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            style: const TextStyle(
              fontFamily: "SF Pro Rounded",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
            decoration: InputDecoration(
              filled: true,
              hintText: "Garage Name",
              isCollapsed: true,
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
              fillColor: AppColors.input,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
