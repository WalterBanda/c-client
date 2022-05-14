import 'package:client/core/route/router.dart';
import 'package:client/core/route/routes.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:client/styles/ui/colors.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String id = "login";

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
              const SizedBox(height: 15),
              authInput(
                hint: "Enter your Password",
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

Widget authInput({required String hint,TextEditingController? controller) {
  return SizedBox(
    width: 290,
    height: 52,
    child: TextField(

      expands: true,
      maxLines: null,
      minLines: null,controller: controller,cursorColor: Colors.green,
      decoration: InputDecoration(
        filled: true,
        isCollapsed: true,
        contentPadding: const EdgeInsets.fromLTRB(30, 17, 17, 0),
        fillColor: AppColors.input,
        border: InputBorder.none,
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: "SF Pro Rounded",
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
      ),
    ),
  );
}
