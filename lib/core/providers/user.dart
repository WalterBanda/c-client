import 'package:client/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../screens/auth/onboarding.dart';
import '../routes/router.dart';
import '../routes/routes.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _user = UserModel.clear();

  init() {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel userModel, _) => userModel.toFirestore())
          .get()
          .then((snap) {
        _user = snap.data()!;
        notifyListeners();
      });
    } else {
      _user = UserModel.clear();
      notifyListeners();
    }

    if (_user == UserModel.clear()) {
      GlobalNavigator.router.currentState!
          .pushReplacementNamed(GlobalRoutes.auth);
    }
  }

  UserModel get user => _user;

  void updateUser(UserModel user) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, _) => userModel.toFirestore())
        .update(_user.toFirestore());
  }

  void _resolveAuthError(
      {required FirebaseAuthException error,
      required BuildContext context,
      required SignInMethods signInMethods}) {
    ScaffoldMessenger.of(context).showSnackBar(
      alertSnackBar(
        message:
            "${signInMethods.toName()} Authentication Failed 😢 \n \n ${error.message}",
      ),
    );
  }

  void createUser({
    required BuildContext context,
    required UserModel payload,
    SignInMethods signInMethods = SignInMethods.email,
  }) {
    if (signInMethods == SignInMethods.email) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: payload.email, password: payload.password)
          .then((credentials) {
            credentials.user!.updateDisplayName(payload.name);
            credentials.user!.updatePhotoURL(payload.profilePhoto);
            FirebaseFirestore.instance
                .collection("users")
                .doc(credentials.user!.uid)
                .withConverter(
                    fromFirestore: UserModel.fromFirestore,
                    toFirestore: (UserModel userModel, _) =>
                        userModel.toFirestore())
                .set(
                  UserModel(
                    uid: credentials.user!.uid,
                    email: payload.email,
                    password: payload.password,
                    name: payload.name,
                    phone: payload.phone,
                    address: payload.address,
                    roles: payload.roles,
                  ),
                );
          })
          .then((_) => init())
          .then((_) => GlobalNavigator.router.currentState!
              .pushReplacementNamed(GlobalRoutes.switchRoles))
          .onError((FirebaseAuthException error, stackTrace) {
            _resolveAuthError(
              error: error,
              context: context,
              signInMethods: SignInMethods.email,
            );
            return;
          });
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel userModel, _) => userModel.toFirestore())
          .set(payload);
    }
  }

  void authUser({
    required BuildContext context,
    required SignInMethods signInMethods,
    String? email,
    String? password,
  }) async {
    switch (signInMethods) {
      case SignInMethods.email:
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!)
            .then((_) => init())
            .then((_) => GlobalNavigator.router.currentState!
                .pushReplacementNamed(GlobalRoutes.switchRoles))
            .onError(
              (FirebaseAuthException error, stackTrace) => _resolveAuthError(
                error: error,
                context: context,
                signInMethods: SignInMethods.email,
              ),
            );
        break;
      case SignInMethods.google:
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((credentials) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(credentials.user!.uid)
              .withConverter(
                  fromFirestore: UserModel.fromFirestore,
                  toFirestore: (UserModel userModel, _) =>
                      userModel.toFirestore())
              .get()
              .then((doc) {
                if (doc.exists == false) {
                  if (credentials.user!.photoURL == null) {
                    credentials.user!.updatePhotoURL(UserModel.clear(
                            customName: credentials.user!.displayName!)
                        .profilePhoto);
                  }
                  createUser(
                    context: context,
                    payload: UserModel(
                      name: credentials.user!.displayName!,
                      email: credentials.user!.email!,
                      uid: credentials.user!.uid,
                      password:
                          credentials.user!.refreshToken ?? "No Auth Token",
                      phone: "No Phone Number",
                      address: "No address",
                      profileShot: credentials.user!.photoURL,
                      roles: [Roles.user],
                    ),
                    signInMethods: SignInMethods.google,
                  );
                }
              })
              .then((_) => init())
              .then(
                (_) => GlobalNavigator.router.currentState!
                    .pushReplacementNamed(GlobalRoutes.switchRoles),
              );
        }).onError((FirebaseAuthException error, stackTrace) {
          _resolveAuthError(
            error: error,
            context: context,
            signInMethods: SignInMethods.google,
          );
        });

        break;
      case SignInMethods.github:
        FirebaseAuth.instance
            .signInWithPopup(GithubAuthProvider())
            .then((credentials) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(credentials.user!.uid)
              .withConverter(
                  fromFirestore: UserModel.fromFirestore,
                  toFirestore: (UserModel userModel, _) =>
                      userModel.toFirestore())
              .get()
              .then((doc) {
                if (doc.exists == false) {
                  if (credentials.user!.photoURL == null) {
                    credentials.user!.updatePhotoURL(UserModel.clear(
                            customName: credentials.user!.displayName!)
                        .profilePhoto);
                  }
                  createUser(
                    context: context,
                    payload: UserModel(
                      name: credentials.user!.displayName!,
                      email: credentials.user!.email!,
                      uid: credentials.user!.uid,
                      password:
                          credentials.user!.refreshToken ?? "No Auth Token",
                      phone: "No Phone Number",
                      address: "No address",
                      profileShot: credentials.user!.photoURL,
                      roles: [Roles.user],
                    ),
                    signInMethods: SignInMethods.github,
                  );
                }
              })
              .then((_) => init())
              .then(
                (_) => GlobalNavigator.router.currentState!
                    .pushReplacementNamed(GlobalRoutes.switchRoles),
              );
        }).onError((FirebaseAuthException error, stackTrace) {
          _resolveAuthError(
            error: error,
            context: context,
            signInMethods: SignInMethods.github,
          );
        });
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          alertSnackBar(message: "Unable to Sign In try again"),
        );
    }
  }

  // User SignOut
  void signOut(BuildContext context) {
    try {
      FirebaseAuth.instance.signOut();
      _user = UserModel.clear();
      notifyListeners();

      GlobalNavigator.router.currentState!
          .pushReplacementNamed(GlobalRoutes.auth);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        alertSnackBar(message: "Unable to SignOut"),
      );
    }
  }
}
