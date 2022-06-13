import 'package:client/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/auth/onboarding.dart';
import '../routes/router.dart';
import '../routes/routes.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _user;
  static final FirebaseAuth _authInstance = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance
      .collection("users")
      .doc(_authInstance.currentUser!.uid)
      .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (userModel, _) => userModel.toFirestore());

  UserModel get user => _user;

  void updateUser(UserModel user) {
    _db.update(_user.toFirestore());
  }

  void createUser({
    required BuildContext context,
    required UserModel payload,
    SignInMethods signInMethods = SignInMethods.email,
  }) {
    if (signInMethods == SignInMethods.email) {
      try {
        _authInstance
            .createUserWithEmailAndPassword(
                email: payload.email, password: payload.password)
            .then((_) {
          _authInstance.currentUser!.updateDisplayName(payload.name);
          _authInstance.currentUser!.updatePhotoURL(payload.profilePhoto);
          _db.set(payload);
        }).then((_) => GlobalNavigator.router.currentState!
                .pushReplacementNamed(GlobalRoutes.switchRoles));
      } on FirebaseAuthException catch (e) {
        String message;
        String? resolveLabel;
        VoidCallback? resolveCallback;

        switch (e.code) {
          case 'email-already-in-use':
            message =
                "The email is already in use, choose another one or login";
            resolveLabel = "Login";
            resolveCallback = () => AuthRouter.router.currentState!
                .pushReplacementNamed(AuthRoutes.login);
            break;
          case 'invalid-email':
            message = "The email format is invalid, check your email";
            break;
          case 'operation-not-allowed':
            message = "An Error Occured, please Try Again";
            break;
          case 'weak-password':
            message = "Your Password is weak, choose a stronger password";
            break;
          default:
            message = "Unable to connect, check your internet";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          alertSnackBar(
            message: message,
            errorLabel: resolveLabel,
            errorCallback: resolveCallback,
          ),
        );
      }
    } else {
      _db.set(payload).then((_) => GlobalNavigator.router.currentState!
          .pushReplacementNamed(GlobalRoutes.switchRoles));
    }
  }

  void authUser(
      {required BuildContext context, required SignInMethods signInMethods}) {
    switch (signInMethods) {
      case SignInMethods.email:
        break;
      default:
    }
  }

  // User SignOut
  void signOut({required BuildContext context}) {
    _authInstance.signOut().then((_) => _user = UserModel.clear()).then((_) =>
        GlobalNavigator.router.currentState!
            .pushReplacementNamed(GlobalRoutes.auth));
  }
}
