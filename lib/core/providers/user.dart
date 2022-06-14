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
  static final _db = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (userModel, _) => userModel.toFirestore());

  UserModel get user {
    // TODO Implement data fetching to firestore
    return _user;
  }

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
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: payload.email, password: payload.password)
            .then((_) {
          FirebaseAuth.instance.currentUser!.updateDisplayName(payload.name);
          FirebaseAuth.instance.currentUser!
              .updatePhotoURL(payload.profilePhoto);
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

  void authUser({
    required BuildContext context,
    required SignInMethods signInMethods,
    UserModel? payload,
  }) {
    switch (signInMethods) {
      case SignInMethods.email:
        try {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: payload!.email, password: payload.password)
              .then(
                (_) => GlobalNavigator.router.currentState!
                    .pushReplacementNamed(GlobalRoutes.switchRoles),
              );
        } on FirebaseAuthException catch (e) {
          String message;
          String? resolveLabel;
          VoidCallback? resolveCallback;

          switch (e.code) {
            case 'user-not-found':
              message = "Your probably dont have an Account create one";
              resolveLabel = "SignUp";
              resolveCallback = () => AuthRouter.router.currentState!
                  .pushReplacementNamed(AuthRoutes.register);
              break;
            case 'invalid-email':
              message = "The email format is invalid, check your email";
              break;
            case 'user-disabled':
              message =
                  "User user account is disabled, contact support for how to recover your account";
              break;
            case 'wrong-password':
              message = "Your Password incorrect, check your password again";
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
        break;
      case SignInMethods.google:
        FirebaseAuth.instance
            .signInWithPopup(GoogleAuthProvider())
            .then((credentials) {
          _db.get().then((doc) {
            if (doc.exists == false) {
              createUser(
                context: context,
                payload: UserModel(
                  name: credentials.user!.displayName!,
                  email: credentials.user!.email!,
                  password: credentials.user!.refreshToken ?? "No Auth Token",
                  phone: "No Phone Number",
                  address: "No address",
                  profileShot: credentials.user!.photoURL!,
                  roles: [Roles.user],
                  description:
                      "Currently you have no description about you, add your description about you so that other people can know about you",
                ),
                signInMethods: SignInMethods.google,
              );
            } else {
              GlobalNavigator.router.currentState!
                  .pushReplacementNamed(GlobalRoutes.switchRoles);
            }
          });
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            alertSnackBar(
              message: "Google SignIn Failed",
            ),
          );
          return Future.error("Google SignIn Failed");
        });
        break;
      case SignInMethods.github:
        FirebaseAuth.instance
            .signInWithPopup(GithubAuthProvider())
            .then((credentials) {
          _db.get().then((doc) {
            if (doc.exists == false) {
              createUser(
                context: context,
                payload: UserModel(
                  name: credentials.user!.displayName!,
                  email: credentials.user!.email!,
                  password: credentials.user!.refreshToken ?? "No Auth Token",
                  phone: "No Phone Number",
                  address: "No address",
                  profileShot: credentials.user!.photoURL!,
                  roles: [Roles.user],
                  description:
                      "Currently you have no description about you, add your description about you so that other people can know about you",
                ),
                signInMethods: SignInMethods.github,
              );
            } else {
              GlobalNavigator.router.currentState!
                  .pushReplacementNamed(GlobalRoutes.switchRoles);
            }
          });
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            alertSnackBar(
              message: "Github SignIn Failed",
            ),
          );
          return Future.error("Github SignIn Failed");
        });
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          alertSnackBar(message: "Unable to Sign In try again"),
        );
    }
  }

  // User SignOut
  void signOut({required BuildContext context}) {
    FirebaseAuth.instance.signOut().then((_) => _user = UserModel.clear()).then(
        (_) => GlobalNavigator.router.currentState!
            .pushReplacementNamed(GlobalRoutes.auth));
  }
}
