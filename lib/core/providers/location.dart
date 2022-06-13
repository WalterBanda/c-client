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

      if (!serviceenabled) return;
    }
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();

      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) return;
    }
    LocationData currentLocation = await _location.getLocation();
    _userLocation = LatLng(
      currentLocation.latitude!.toDouble(),
      currentLocation.longitude!.toDouble(),
    );

    updateMap();
    notifyListeners();
  }
}

class LocationProvider with ChangeNotifier {
  // create a location varibale
  late Location _location;

  //create a getter so that its not exposed
  Location get location => _location;

  LatLng _locationPosition = LatLng(28.555, 28.555);

  LatLng get locationPosition => _locationPosition;

  bool locationServiceActive = true;
  LocationProvider() {
    _location = Location();
  }
  initialization() {
    getuserLocation();
  }

  getuserLocation() async {
    bool serviceenabled;
    PermissionStatus permissionGranted;
    //  check if user is having permission or not
    serviceenabled = await location.serviceEnabled();

    if (!serviceenabled) {
      serviceenabled = await location.requestService();

      if (!serviceenabled) return;
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) return;
    }
    location.onLocationChanged.listen((LocationData currentlocation) {
      _locationPosition = LatLng(
        currentlocation.latitude!.toDouble(),
        currentlocation.longitude!.toDouble(),
      );
    });
    notifyListeners();
  }
}
