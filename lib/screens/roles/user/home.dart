import 'package:client/router/roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../../styles/icons/chap_chap_icons.dart';
import '../../../styles/ui/colors.dart';
import '../../auth/onboarding.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  static const String id = "user";

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final MapController _mapController = MapController();
  late LatLng _currentLocation;

  Location location = Location();

  void _getUserLocation({LatLng? loc}) {
    // Check for Location Permissions

    setState(() {
      _currentLocation = loc ?? LatLng(-1.286389, 36.817223);
    });
  }

  void _updateMapLocation() {
    _getUserLocation(loc: LatLng(-0.303099, 36.080025));
    _mapController.move(_currentLocation, 18);
  }

  @override
  void initState() {
    super.initState();

    // Get User Location
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_currentLocation == null) _loadingState() else buildMap(),
        buildUtils(context),
      ],
    );
  }

  Widget _loadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("Loading Map, Please wait"),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  FlutterMap buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: _currentLocation,
        zoom: 17,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return const Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: _currentLocation,
              builder: (ctx) => const Icon(ChapChap.pin),
            ),
          ],
        ),
      ],
    );
  }

  Positioned buildUtils(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 10,
      right: 10,
      child: Center(
        child: ConstrainedBox(
          constraints: pageConstraints,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  _updateMapLocation();
                  print({"Returned Location": _currentLocation});
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: const Icon(Icons.my_location_rounded),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                decoration: BoxDecoration(
                  color: AppColors.bgDark,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const SearchOverlay());
                  },
                  style: const TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(ChapChap.search_filled),
                    fillColor: AppColors.input,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Looking for a Garage",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchOverlay extends StatelessWidget {
  const SearchOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: pageConstraints,
        child: Dialog(
          backgroundColor: AppColors.bgDark,
          alignment: const Alignment(0.0, -0.6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onTap: () {},
                  style: const TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(ChapChap.search_filled),
                    fillColor: AppColors.input,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.success,
                        width: 2,
                      ),
                    ),
                    hintText: "Looking for a Garage",
                  ),
                ),
                const SizedBox(height: 20),
                // TODO Fetch Garages Implementation
                const Text(
                  "Search for nearby Garages",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
