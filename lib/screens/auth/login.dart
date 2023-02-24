import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 🏘️ Local imports
import '../../core/models/user.dart';
import '../../core/providers/user.dart';
import '../../router/router.dart';
import '../../core/models/garage.dart';
import '../../router/routes.dart';
import '../../styles/ui/colors.dart';
import 'onboarding.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  static const String id = "login";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

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
          child: SingleChildScrollView(
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
                        hint: "Enter your Email",
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        validator: (value) =>
                            Validator.validateEmail(email: value),
                        inputType: TextInputType.emailAddress,
                        prefix: const Icon(
                          Icons.email_rounded,
                          size: 15,
                        ),
                      ),
                      const SizedBox(height: 14),
                      authInput(
                        hint: "Enter your Password",
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        validator: (value) =>
                            Validator.validatePassword(password: value),
                        inputType: TextInputType.visiblePassword,
                        private: true,
                        prefix: const Icon(
                          Icons.lock_rounded,
                          size: 15,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: kIsWeb ? 50 : null,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _userAuth(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 124),
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
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => AuthRouter.router.currentState!
                      .pushReplacementNamed(AuthRoutes.resetPassword),
                  child: const Text(
                    "Forgot password?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 13,
                      fontFamily: "SF Pro Rounded",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                createAccountShortcut()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _userAuth({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    Provider.of<UserProvider>(context, listen: false).authUser(
      context: context,
      signInMethods: SignInMethods.email,
      email: email,
      password: password,
    );
  }
}

Widget authInput({
  String? hint,
  required TextEditingController? controller,
  required FocusNode focusNode,
  FormFieldValidator? validator,
  String? errorMessage,
  TextInputType? inputType,
  bool private = false,
  Widget? prefix,
  Widget? suffix,
  GestureTapCallback? onTap,
}) {
  return SizedBox(
    width: 300,
    child: TextFormField(
      controller: controller,
      onTap: onTap,
      focusNode: focusNode,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      obscureText: private,
      keyboardType: inputType,
      style: const TextStyle(
        fontFamily: "SF Pro Rounded",
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      ),
      decoration: InputDecoration(
        filled: true,
        isCollapsed: true,
        prefixIcon: prefix,
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.fromLTRB(30, 17, 0, 17),
        fillColor: AppColors.input,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintText: hint,
        helperText: errorMessage,
        helperStyle: const TextStyle(
          fontFamily: "SF Pro Rounded",
          fontSize: 10,
          color: AppColors.error,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    ),
  );
}

class Validator {
  static String? validateName({required String name, String? label}) {
    if (name.isEmpty) {
      return '${label ?? 'Name'} can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  static String? validatePhone({required String phone}) {
    RegExp phoneRegExp = RegExp(r"^\+(?:[0-9] ?){6,14}[0-9]$");
    if (phone.isEmpty) {
      return 'Please add your phone number easier communications';
    } else if (!phoneRegExp.hasMatch(phone)) {
      return 'Phone number has to be in International Format ie +254';
    }
    return null;
  }

  static String? validateAddress({Address? address}) {
    if (address == null) {
      return 'Please add your address for garage booking';
    }
    return null;
  }
}
