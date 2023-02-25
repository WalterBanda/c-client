import 'package:client/core/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("InputValidator Tests", () {
    group("validateName", () {
      test("Check valid name", () {
        final res = InputValidator.validateName(name: "Dev");
        expect(res, null);
      });

      test("Check invalid name", () {
        final res = InputValidator.validateName(name: "");
        expect(res, "Name can't be empty");
      });

      test("Check invalid name with custom label", () {
        final res = InputValidator.validateName(name: "", label: "Username");
        expect(res, "Username can't be empty");
      });
    });

    group("validateEmail", () {
      test("Check valid email", () {
        final res = InputValidator.validateEmail(email: "hello@example.web");
        expect(res, null);
      });

      test("Check invalid email", () {
        final res = InputValidator.validateEmail(email: "hello@sds@hsd.com");
        expect(res, "Enter a correct email");
      });

      test("Check empty email", () {
        final res = InputValidator.validateEmail(email: "");
        expect(res, "Email can't be empty");
      });
    });

    group("validatePassword", () {
      test("Check valid password", () {
        final res = InputValidator.validatePassword(password: "123456780sd");
        expect(res, null);
      });
      test("Check invalid password", () {
        final res = InputValidator.validatePassword(password: "12345");
        expect(res, "Enter a password with length at least 6");
      });
      test("Check empty password", () {
        final res = InputValidator.validatePassword(password: "");
        expect(res, "Password can't be empty");
      });
    });

    group("validatePhone", () {
      test("Check valid phone", () {
        final res = InputValidator.validatePhone(phone: "+254723456789");
        expect(res, null);
      });
      test("Check invalid phone", () {
        // 😿 Local phone numbers fail since query is set to accept international phone numbers
        final res = InputValidator.validatePhone(phone: "0723456789");
        expect(res,
            'Phone number has to be in International Format ie +<countrycode>');
      });
      test("Check empty phone", () {
        final res = InputValidator.validatePhone(phone: "");
        expect(res, 'Please add your phone number easier communications');
      });
    });

    // TODO: Update address test after model and validator change
  });
}
