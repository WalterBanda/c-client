import 'package:flutter/material.dart';

import '../../../router/router.dart';
import '../../../router/routes.dart';
import '../../../styles/icons/chapchap.dart';
import '../../../styles/ui/colors.dart';

class Logo extends StatelessWidget {
  /// This widget displays the branding with consists of the logo and brand text
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Icon(ChapChap.logo, size: 160),
        SizedBox(height: 18),
        Text(
          "ChapChap",
          style: TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class CreateAccountShortcut extends StatelessWidget {
  const CreateAccountShortcut({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: TextButton(
      onPressed: () => AuthRouter.router.currentState!
          .pushReplacementNamed(AuthRoutes.register),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Don’t have an Account ?  ",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Create Account",
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Color(0xff4285f4),
              color: AppColors.success,
              fontSize: 13,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
  }

}