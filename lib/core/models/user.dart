import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Roles { user, garage, admin, error }

// TODO Implement Extension Function for Roles Transformation
extension RolesListTransform on List {
  List<String> toRolesString() {
    // return toString().split('.').last;
    return map((role) => role.toString().split('.').last).toList();
  }
}

List<Roles> toRoles(List<String> data) {
  return data
      .map((role) => Roles.values.firstWhere(
            (element) => element.toString().split('.').last == role,
            orElse: () => Roles.error,
          ))
      .toList();
}

enum SignInMethods { google, github, email }

class UserModel {
  String name, email, phone, profilePhoto, address, description, password;
  List<Roles> roles;
  User? firebaseUser;
  String? uid;

  UserModel({
    // required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    String? profileShot,
    required this.roles,
    String? userInfo,
  })  : firebaseUser = FirebaseAuth.instance.currentUser,
        uid = FirebaseAuth.instance.currentUser!.uid,
        description = userInfo ??
            "Currently you have no description about you, add your description about you so that other people can know about you",
        profilePhoto = profileShot ??
            "https://ui-avatars.com/api/?name=\"$name\"&background=${Colors.primaries[Random().nextInt(Colors.primaries.length)].toString().substring(39, 45)}&color=fff";

  createProfilePic() {
    String profileColor = Colors
        .primaries[Random().nextInt(Colors.primaries.length)]
        .toString()
        .substring(39, 45);
    profilePhoto =
        "https://ui-avatars.com/api/?name=\"$name\"&background=$profileColor&color=fff";
  }

  factory UserModel.clear({String? customName}) {
    return UserModel(
      name: customName ?? "name",
      email: "email",
      password: "password",
      phone: "phone",
      address: "address",
      roles: [Roles.error],
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      name: data!["name"],
      email: data["email"],
      password: data["password"],
      phone: data["phone"],
      address: data["address"],
      profileShot: data["profilePhoto"],
      roles: toRoles(
        List<String>.from(
          data["roles"],
        ),
      ),
      userInfo: data["description"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "profilePhoto": profilePhoto,
      "roles": roles.toRolesString(),
      "description": description,
    };
  }
}
