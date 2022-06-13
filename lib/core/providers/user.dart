import 'package:client/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _user;
  static FirebaseAuth authInstance = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance
      .collection("users")
      .doc(authInstance.currentUser!.uid)
      .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (userModel, _) => userModel.toFirestore());

  UserModel get user {
    _db.get().then((data) {
      _user = data.data()!;
    });
    return _user;
  }

  updateUser(UserModel user) {
    _user = user;
    _db.update(_user.toFirestore());
  }

  createUser({required BuildContext context}) {}
  authUser({required BuildContext context}) {}
  signOut({required BuildContext context}) async {
    await authInstance.signOut();
  }
}
