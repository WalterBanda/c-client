import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

// 🏘️ Local imports
import '../../screens/auth/onboarding.dart';

class LocationProvider extends ChangeNotifier {
  Location locationInstance = Location();

  late LatLng _userLocation = LatLng(-0.303099, 36.080025);

  LatLng get location => _userLocation;

  Future<LatLng> checkPermissions({LatLng? loc}) async {
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

      if (permissionGranted != PermissionStatus.granted ||
          permissionGranted != PermissionStatus.grantedLimited) {
        return Future.error("Location Permissions denied ⚠");
      } else {
        locationInstance.enableBackgroundMode(enable: true);
        locationInstance.changeSettings(accuracy: LocationAccuracy.high);
      }
    }

    try {
      final loc = await locationInstance.getLocation();
      return LatLng(loc.latitude!.toDouble(), loc.longitude!.toDouble());
    } catch (error) {
      return Future.error("Unable to get location 😟");
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
