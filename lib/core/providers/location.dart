import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../screens/auth/onboarding.dart';

class AppData extends ChangeNotifier {
  Location locationInstance = Location();

  late LatLng _userLocation = LatLng(-0.303099, 36.080025);

  LatLng get location => _userLocation;

  Future<LatLng> checkPermissions({LatLng? loc}) async {
    // _userLocation = loc;
    // updateMap();
    // notifyListeners();

    locationInstance.changeSettings(accuracy: LocationAccuracy.high);

    bool serviceenabled;
    PermissionStatus permissionGranted;
    //  check if user is having permission or not
    serviceenabled = await locationInstance.serviceEnabled();

    if (!serviceenabled) {
      serviceenabled = await locationInstance.requestService();

      if (!serviceenabled) return Future.error("Location Service disabled ⚠");
    }
    permissionGranted = await locationInstance.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationInstance.requestPermission();

      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) {
        return Future.error("Location Permissions denied ⚠");
      }
    }

    try {
      final loc = await locationInstance.getLocation();
      return LatLng(loc.latitude!.toDouble(), loc.longitude!.toDouble());
    } on PositionError catch (error) {
      return Future.error("Unable to get location 😟 \n\n ${error.message}");
    }
  }

  updateLocation(LatLng loc) {
    _userLocation = loc;
    notifyListeners();
  }

  void getUserLocation(
      {required BuildContext context,
      MapController? controller,
      LocationData? locStream}) {
    checkPermissions().then((loc) {
      _userLocation = loc;
      notifyListeners();
      if (controller != null) {
        controller.move(_userLocation, 17);
      }
    }).onError((String error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        alertSnackBar(message: error),
      );
    });
  }
}
