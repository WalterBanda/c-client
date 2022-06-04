import 'package:client/router/roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../styles/icons/chap_chap_icons.dart';
import '../../../styles/ui/colors.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  static const String id = "user";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapLayer(),
        Positioned(
          bottom: 30,
          left: 10,
          right: 10,
          child: Center(
            child: ConstrainedBox(
              constraints: pageConstraints,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                      elevation: 0,
                      // minimumSize: Size(20, 20),
                      // maximumSize: Size(48, 48),
                      fixedSize: Size(18, 48),
                    ),
                    child: const Icon(Icons.my_location_rounded, size: 18),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 22),
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
        ),
      ],
    );
  }
}

class MapLayer extends StatefulWidget {
  const MapLayer({Key? key}) : super(key: key);

  // TODO Map implementation 🚧

  @override
  State<MapLayer> createState() => _MapLayerState();
}

class _MapLayerState extends State<MapLayer> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
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
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => const Icon(ChapChap.pin),
            ),
          ],
        ),
      ],
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
