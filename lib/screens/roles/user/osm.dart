import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/location.dart';
import '../../../styles/icons/chap_chap_icons.dart';

class OSM extends StatelessWidget {
  OSM({super.key});

  MapController controller = MapController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, details, child) {
        return FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: details.location,
            minZoom: 18,
            maxZoom: 12,
            onMapCreated: (_) {
              details.getUserLocation(context: context, controller: controller);
              details.locationInstance.onLocationChanged.listen((loc) {
                details.updateLocation(
                  LatLng(loc.latitude!.toDouble(), loc.longitude!.toDouble()),
                );
                controller.move(details.location, 17);
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
