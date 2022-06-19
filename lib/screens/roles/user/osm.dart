import 'package:client/screens/auth/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/location.dart';
import '../../../styles/icons/chap_chap_icons.dart';

class OSM extends StatelessWidget {
  OSM({super.key});

  MapController controller = MapController();
  final Location _location = Location();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, details, child) {
        return FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: details.location,
            zoom: 17,
            onMapCreated: (_) {
              details.getUserLocation().then((lc) {
                controller.move(lc, 17);
                _location.onLocationChanged.listen((loc) {
                  controller.move(
                      LatLng(
                          loc.latitude!.toDouble(), loc.latitude!.toDouble()),
                      17);
                });
              }).onError((String error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(
                  alertSnackBar(message: error),
                );
              });
            },
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: details.location,
                  builder: (ctx) => const Icon(ChapChap.pin),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
