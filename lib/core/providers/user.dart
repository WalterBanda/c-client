import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🏘️ Local imports
import '../models/garage.dart';
import '../models/user.dart';
import '../../screens/auth/onboarding.dart';
import '../../router/router.dart';
import '../../router/routes.dart';

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

  UserProvider() {
    init();
  }

  UserModel get user => _user;

  void updateUser({
    required BuildContext context,
    required String name,
    required Address? address,
    required String phone,
    required String description,
    required String email,
  }) {
    if (_user != UserModel.clear() &&
        FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "name": name.isEmpty ? _user.name : name,
        "email": email.isEmpty ? _user.email : email,
        "phone": phone.isEmpty ? _user.phone : phone,
        "address": address != null
            ? address.toFirestore()
            : _user.address.toFirestore(),
        "description": description.isEmpty ? _user.description : description,
      }).then((value) {
        User? currentDetails = FirebaseAuth.instance.currentUser;
        currentDetails?.updateDisplayName(name.isEmpty ? _user.name : name);
        currentDetails?.updateEmail(email.isEmpty ? _user.email : email);
      }).then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .withConverter(
                fromFirestore: UserModel.fromFirestore,
                toFirestore: (UserModel userModel, _) =>
                    userModel.toFirestore())
            .get()
            .then((snap) {
          _user = snap.data()!;
          notifyListeners();
        }).then((value) => Navigator.of(context, rootNavigator: true).pop());
      });
    }
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

  void socialAuth(
      {required SignInMethods auth,
      required UserCredential credentials,
      required BuildContext context}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credentials.user!.uid)
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, _) => userModel.toFirestore())
        .get()
        .then((doc) {
          if (doc.exists == false) {
            if (credentials.user!.photoURL == null) {
              credentials.user!.updatePhotoURL(
                  UserModel.clear(customName: credentials.user!.displayName!)
                      .profilePhoto);
            }
            createUser(
              context: context,
              payload: UserModel(
                name: credentials.user!.displayName!,
                email: credentials.user!.email!,
                uid: credentials.user!.uid,
                password: credentials.user!.refreshToken ?? "No Auth Token",
                phone: "No Phone Number",
                address: Garage.sample().address,
                profileShot: credentials.user!.photoURL,
                roles: [Roles.user],
              ),
              signInMethods: auth,
            );
          }
        })
        .then((_) => init())
        .then(
          (_) => GlobalNavigator.router.currentState!
              .pushReplacementNamed(GlobalRoutes.switchRoles),
        );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(googleProvider);
  }

  void googleSignIn(BuildContext context) {
    if (kIsWeb) {
      FirebaseAuth.instance
          .signInWithPopup(GoogleAuthProvider())
          .then(
            (credentials) => socialAuth(
                auth: SignInMethods.google,
                credentials: credentials,
                context: context),
          )
          .onError(
            (FirebaseAuthException error, stackTrace) => _resolveAuthError(
              error: error,
              context: context,
              signInMethods: SignInMethods.google,
            ),
          );
    } else {
      signInWithGoogle()
          .then((credentials) => socialAuth(
              auth: SignInMethods.google,
              credentials: credentials,
              context: context))
          .onError(
            (FirebaseAuthException error, stackTrace) => _resolveAuthError(
              error: error,
              context: context,
              signInMethods: SignInMethods.google,
            ),
          );
    }
  }

  Future<UserCredential> signInWithGitHub() async {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }

  void githubSignIn(BuildContext context) {
    if (kIsWeb) {
      FirebaseAuth.instance
          .signInWithPopup(GithubAuthProvider())
          .then(
            (credentials) => socialAuth(
                auth: SignInMethods.github,
                credentials: credentials,
                context: context),
          )
          .onError(
            (FirebaseAuthException error, stackTrace) => _resolveAuthError(
              error: error,
              context: context,
              signInMethods: SignInMethods.github,
            ),
          );
    } else {
      signInWithGitHub()
          .then((credentials) => socialAuth(
              auth: SignInMethods.github,
              credentials: credentials,
              context: context))
          .onError(
            (FirebaseAuthException error, stackTrace) => _resolveAuthError(
              error: error,
              context: context,
              signInMethods: SignInMethods.google,
            ),
          );
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
        googleSignIn(context);
        break;
      case SignInMethods.github:
        githubSignIn(context);
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

  void resetPassword({required String email}) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then(
          (value) => alertSnackBar(
              message:
                  "Password reset request succesfully sent, check your email"),
        )
        .catchError(
          (error) => alertSnackBar(
              message: "Unable to send request, ${error.toString()}"),
        )
        .then((value) => AuthRouter.router.currentState
            ?.pushReplacementNamed(AuthRoutes.splash));
  }
}
