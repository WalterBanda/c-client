import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class AppData extends ChangeNotifier {
  // MapController mapController = MapController();
  final Location _location = Location();

  late LatLng _userLocation = LatLng(-0.303099, 36.080025);

  LatLng get location => _userLocation;

  Future<LatLng> getUserLocation({LatLng? loc}) async {
    // _userLocation = loc;
    // updateMap();
    // notifyListeners();

    _location.changeSettings(accuracy: LocationAccuracy.high);

    bool serviceenabled;
    PermissionStatus permissionGranted;
    //  check if user is having permission or not
    serviceenabled = await _location.serviceEnabled();

    if (!serviceenabled) {
      serviceenabled = await _location.requestService();

      // TODO Location checking

      if (!serviceenabled) return Future.error("Location Service disabled ⚠");
    }
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();

      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) {
        return Future.error("Location Permissions denied ⚠");
      }
      ;
    }
    await _location.getLocation().then((LocationData location) {
      _userLocation = LatLng(
        location.latitude!.toDouble(),
        location.longitude!.toDouble(),
      );
      notifyListeners();
    });

    return _userLocation;
  }
}
