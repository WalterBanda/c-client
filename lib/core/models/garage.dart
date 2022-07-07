import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class Garage {
  String name, description, image, userUid;
  Address address;

  Garage({
    required this.name,
    required this.address,
    required this.description,
    required this.image,
    required this.userUid,
  });

  factory Garage.sample({String? name, Address? address}) {
    return Garage(
      name: name ?? "Garage Name ⚠️",
      address: address ??
          Address(name: "address", position: LatLng(-0.303099, 36.080025)),
      description: "description",
      image:
          "https://ui-avatars.com/api/?name=GarageName&background=f2f2f2&color=fff",
      userUid: "userUid",
    );
  }

  factory Garage.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Garage(
      name: data!["name"],
      description: data['description'],
      image: data['image'],
      address: data['address'],
      userUid: data['userUid'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "description": description,
      "image": image,
      "address": address,
      "userUid": userUid,
    };
  }
}

String createProfilePic({required String name}) {
  String profileColor = Colors
      .primaries[Random().nextInt(Colors.primaries.length)]
      .toString()
      .substring(39, 45);
  return "https://ui-avatars.com/api/?name=\"$name\"&background=$profileColor&color=fff";
}

class Address {
  String name;
  LatLng position;

  Address({
    required this.name,
    required this.position,
  });
}
