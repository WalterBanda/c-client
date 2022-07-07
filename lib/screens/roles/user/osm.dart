import 'dart:math';

import 'package:client/core/providers/appdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../core/models/garage.dart';
import '../../../core/providers/location.dart';
import '../../../styles/icons/chap_chap_icons.dart';

class OSM extends StatelessWidget {
  OSM({super.key});

  final MapController controller = MapController();

  List<Garage> getGarages(BuildContext context) {
    List<Garage> res = Provider.of<AppData>(context)
        .getGaragesList()
        .then((List<Garage> value) => value)
        .onError((error, stackTrace) => []) as List<Garage>;

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, details, child) {
        return FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: details.location,
            minZoom: 12,
            zoom: 17,
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
            LocationMarkerLayerOptions(),
            MarkerLayerOptions(
              markers: [
                ...getGarages(context).map(
                  (e) => Marker(
                    width: 40.0,
                    height: 40.0,
                    point: e.address.position,
                    builder: (ctx) => Icon(
                      ChapChap.pin,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
