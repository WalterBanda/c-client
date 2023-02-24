import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 🏘️ Local imports
import '../../core/providers/user.dart';
import 'login.dart';
import '../../router/routes.dart';
import '../../router/router.dart';
import '../../styles/ui/colors.dart';
import 'onboarding.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);

  static const String id = "resetPassword";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

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
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    authInput(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        inputType: TextInputType.emailAddress,
                        hint: "Enter Email Address to reset"),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: kIsWeb ? 50 : null,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _resetEmail(
                                email: _emailController.text, context: context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(
                            fontFamily: "SF Pro Rounded",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _resetEmail({required String email, required BuildContext context}) {
    Provider.of<UserProvider>(context, listen: false)
        .resetPassword(email: email);
  }
}
