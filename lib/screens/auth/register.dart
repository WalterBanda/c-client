import 'package:flutter/material.dart';

import '../../core/route/router.dart';
import '../../core/route/routes.dart';
import '../../styles/ui/colors.dart';
import 'login.dart';
import 'onboarding.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  static const id = "register";

  _userRegister() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => AuthRouter.router.currentState!
              .popAndPushNamed(AuthRoutes.onboarding),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildBranding(context),
              const SizedBox(height: 40),
              authInput(
                hint: "Enter your Email",
              ),
              const SizedBox(height: 14),
              authInput(
                hint: "Enter your Password",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _userRegister,
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 124),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              createAccountShortcut()
            ],
          ),
        ),
      ),
    );
  }
}
