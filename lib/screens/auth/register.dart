import 'package:client/styles/icons/chap_chap_icons.dart';
import 'package:flutter/material.dart';

import '../../core/routes/router.dart';
import '../../core/routes/routes.dart';
import '../../styles/ui/colors.dart';
import 'login.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  static const id = "register";

  void _userRegister() {
    GlobalNavigator.router.currentState!
        .pushReplacementNamed(GlobalRoutes.switchRoles);
  }

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
              const SizedBox(height: 40),
              const Text(
                "Create your Account",
                style: TextStyle(
                  fontFamily: "SF Pro Rounded",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              authInput(
                hint: "Enter your Email",
                inputType: TextInputType.emailAddress,
                prefix: const Icon(
                  Icons.email_rounded,
                  size: 15,
                ),
              ),
              const SizedBox(height: 15),
              authInput(
                hint: "Enter your Password",
                inputType: TextInputType.visiblePassword,
                private: true,
                prefix: const Icon(
                  Icons.lock_rounded,
                  size: 15,
                ),
              ),
              const SizedBox(height: 15),
              authInput(
                hint: "Enter your Phone Number",
                inputType: TextInputType.phone,
                prefix: const Icon(
                  Icons.phone_rounded,
                  size: 15,
                ),
              ),
              const SizedBox(height: 15),
              authInput(
                hint: "Enter your Address",
                inputType: TextInputType.streetAddress,
                prefix: const Icon(
                  ChapChap.location,
                  size: 15,
                ),
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
                  "Register",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
