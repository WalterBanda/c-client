import 'package:client/screens/roles/garage/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/garage.dart';
import '../models/user.dart';

class AppData extends ChangeNotifier {
  List<Garage> garages = [];

  createGarage({required Garage garage}) async {
    await FirebaseFirestore.instance
        .collection("garage")
        .doc(garage.userUid)
        .withConverter(
            fromFirestore: Garage.fromFirestore,
            toFirestore: (Garage userModel, _) => userModel.toFirestore())
        .set(garage);
  }

  Future<List<Garage>> getGaragesList() async {
    final res = await FirebaseFirestore.instance
        .collection("garage")
        .withConverter(
            fromFirestore: Garage.fromFirestore,
            toFirestore: (Garage userModel, _) => userModel.toFirestore())
        .get()
        .then((res) {
      garages = res.docs.toList().cast();
      notifyListeners();
    });

    return res.docs.toList().cast() ?? [Garage.sample()];
  }

  Future<Garage> getGarage({required String userUid}) async {
    final res = await FirebaseFirestore.instance
        .collection("garage")
        .doc(userUid)
        .withConverter(
            fromFirestore: Garage.fromFirestore,
            toFirestore: (Garage userModel, _) => userModel.toFirestore())
        .get()
        .onError((error, stackTrace) => Future.error("Unable to Get Garage"));

    return res.data() ?? Garage.sample();
  }
}
