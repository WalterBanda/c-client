import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppData extends ChangeNotifier {
  static final MapController _mapController = MapController();
  static final Location _location = Location();

  // late LatLng _userLocation = LatLng(-1.2833, 36.8166);
  late LatLng _userLocation = LatLng(-0.303099, 36.080025);

  MapController get mapController => _mapController;

  LatLng get location => _userLocation;

  updateMap() {
    _mapController.move(_userLocation, 18);
  }

  initialization() {
    getUserLocation();
  }

  getUserLocation({LatLng? loc}) async {
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

      if (!serviceenabled) return;
    }
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();

      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) return;
    }
    await _location.getLocation().then((LocationData location) {
      _userLocation = LatLng(
        location.latitude!.toDouble(),
        location.longitude!.toDouble(),
      );
      notifyListeners();
    }).then((_) {
      updateMap();
    });
  }
}
