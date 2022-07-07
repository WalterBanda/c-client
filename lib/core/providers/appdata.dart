import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/garage.dart';

class AppData extends ChangeNotifier {
  List<Garage> garages = [];

  late List<GarageRequests> _garageRequest;
  late List<AdminRequests> _adminRequest;

  List<GarageRequests> get garageRequest => _garageRequest;
  List<AdminRequests> get adminRequest => _adminRequest;

  Future<void> createGarage({required Garage garage}) async {
    return await FirebaseFirestore.instance
        .collection("garage")
        .doc()
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

  Future<void> createAdminRequest({required AdminRequests payload}) async {
    return await FirebaseFirestore.instance
        .collection("garageRequests")
        .withConverter(
          fromFirestore: AdminRequests.fromFirestore,
          toFirestore: (AdminRequests req, _) => req.toFirestore(),
        )
        .doc()
        .set(payload);
  }

  Future<void> createGarageRequest({required GarageRequests payload}) async {
    return await FirebaseFirestore.instance
        .collection("garageRequests")
        .withConverter(
          fromFirestore: GarageRequests.fromFirestore,
          toFirestore: (GarageRequests req, _) => req.toFirestore(),
        )
        .doc()
        .set(payload);
  }

  void getGarageRequest() {
    FirebaseFirestore.instance
        .collection("garageRequests")
        .withConverter(
          fromFirestore: GarageRequests.fromFirestore,
          toFirestore: (GarageRequests userModel, _) => userModel.toFirestore(),
        )
        .snapshots()
        .listen((val) {
      _garageRequest = val.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  void getAdminRequest() async {
    await FirebaseFirestore.instance
        .collection("garageRequests")
        .withConverter(
            fromFirestore: AdminRequests.fromFirestore,
            toFirestore: (AdminRequests userModel, _) =>
                userModel.toFirestore())
        .snapshots()
        .listen((val) {
      _adminRequest = val.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }
}

class AdminRequests {
  String userId, description;

  AdminRequests({
    required this.userId,
    required this.description,
  });

  factory AdminRequests.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AdminRequests(
      userId: data!['userId'],
      description: data['description'],
    );
  }

  toFirestore() {
    return {
      "userId": userId,
      "description": description,
    };
  }
}

class GarageRequests {
  String userId;
  Garage garage;

  GarageRequests({required this.garage, required this.userId});

  factory GarageRequests.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return GarageRequests(
      userId: data!['userId'],
      garage: mapToGarage(data['garage']),
    );
  }

  toFirestore() {
    return {
      "userId": userId,
      "garage": garage.toFirestore(),
    };
  }
}

Garage mapToGarage(Map<String, dynamic> data) {
  return Garage(
    name: data["name"],
    description: data['description'],
    image: data['image'],
    address: Address.fromFirestore(data['address']),
    userUid: data['userUid'],
  );
}
