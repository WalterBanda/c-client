import '../models/garage.dart';

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
