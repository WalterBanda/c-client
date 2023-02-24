import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/garage.dart';
// 🏘️ Local imports
import '../../core/models/user.dart';
import '../../core/providers/user.dart';
import '../../router/router.dart';
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

  /// `📖` [validateEmail]
  ///
  /// This is responsible for email validation on the user string
  /// It uses [RegExp] to accomplish this, `more on it will be explained below`
  /// There are only two [Error] states
  ///  - One when there is no input results in 'Email can't be empty'
  ///  - One when there is no match results in 'Enter a correct email'
  ///
  /// I know you are scared of regex, let me explain the Regex `^((\w+(?!.*[.\s]{2})[\w!#$%&'*+-=?^_'{|}~.]+)?\w+)@(([a-zA-Z0-9]+[\w-]*(\.[a-zA-Z0-9-]+)*)\.([a-zA-Z]{2,}))$` below
  ///
  /// `💡` How it works
  ///
  /// The regular expression `^((\w+(?!.*[.\s]{2})[\w!#$%&'*+-=?^_'{|}~.]+)?\w+)@(([a-zA-Z0-9]+[\w-]*(\.[a-zA-Z0-9-]+)*)\.([a-zA-Z]{2,}))$` checks whether a given string is a valid email address or not according to some common email standards such as IETF standards.
  /// Here is how the expression is working:
  ///
  ///  - `^` and `$` match the start and end of the string, respectively. This ensures that the entire string is matched and there are no extra characters before or after the email address.
  ///  - `(\w+(?!.*[.\s]{2})[\w!#$%&'*+-=?^_'{|}~.]+)?` matches the local part of the email address. It starts with one or more word characters `(\w+)` and optionally followed by one or more special characters that are allowed in the local part of an email address according to IETF standards. The negative lookahead `(?!.*[.\s]{2})` ensures that there are no consecutive dots or spaces in the local part of the email address.
  ///  - `\w+` matches the last word character in the local part of the email address, which must be present in any valid email address.
  ///  - `@` matches the "@" symbol, which separates the local and domain parts of the email address.
  ///  - `(([a-zA-Z0-9]+[\w-]*(\.[a-zA-Z0-9-]+)*)\.([a-zA-Z]{2,}))` matches the domain part of the email address. It starts with one or more alphanumeric characters followed by zero or more alphanumeric characters, hyphens, or dots. This is followed by a dot and a top-level domain name consisting of two or more alphabets. The domain part may have one or more subdomains separated by dots.
  ///

  static String? validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(
        r"^((\w+(?!.*[.\s]{2})[\w!#$%&'*+-=?^_'{|}~.]+)?\w+)@(([a-zA-Z0-9]+[\w-]*(\.[a-zA-Z0-9-]+)*)\.([a-zA-Z]{2,}))$");

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
