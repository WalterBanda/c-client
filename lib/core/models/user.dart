import 'package:cloud_firestore/cloud_firestore.dart';

enum Roles { user, garage, admin }

class UserModel {
  List<Roles> roles;
  String uid, name, email, phone, profilePhoto, address, description, password;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.profilePhoto,
    required this.roles,
    required this.description,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      uid: data?["uid"],
      name: data?["name"],
      email: data?["email"],
      password: data?["password"],
      phone: data?["phone"],
      address: data?["address"],
      profilePhoto: data?["profilePhoto"],
      roles:
          data?["roles"] is Iterable ? List.from(data?["roles"]) : [Roles.user],
      description: data?["description"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "profilePhoto": profilePhoto,
      "roles": roles,
      "description": description,
    };
  }
}
