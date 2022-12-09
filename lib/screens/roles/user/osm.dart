import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../core/models/garage.dart';
import '../../../core/providers/location.dart';
import '../../../styles/icons/chap_chap_icons.dart';

class OSM extends StatelessWidget {
  OSM({super.key});

  final MapController controller = MapController();

  List<Garage> getGarage(BuildContext context) {
    List<Garage> res = [];
    FirebaseFirestore.instance
        .collection("garage")
        .withConverter(
            fromFirestore: Garage.fromFirestore,
            toFirestore: (Garage userModel, _) => userModel.toFirestore())
        .get()
        .then((val) {
      res = val.docs.toList().cast();
    });

    return res;
  }

  @override
  Widget build(BuildContext context) {
    List<Garage> getGarages = getGarage(context);
    return Consumer<LocationProvider>(
      builder: (context, details, child) {
        return FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: details.location,
            minZoom: 12,
            zoom: 17,
            onMapReady: () {
              details.getUserLocation(context: context, controller: controller);
              details.locationInstance.onLocationChanged.listen((loc) {
                details.updateLocation(
                  LatLng(loc.latitude!.toDouble(), loc.longitude!.toDouble()),
                );
                controller.move(details.location, 17);
              });
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
            ),
            CurrentLocationLayer(),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 120,
                size: const Size(40, 40),
                fitBoundsOptions: const FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: [
                  ...getGarages
                      .map(
                        (e) => Marker(
                          width: 40.0,
                          height: 40.0,
                          point: e.address.position,
                          builder: (ctx) => Icon(
                            ChapChap.pin,
                            color: Colors.primaries[getGarages.indexOf(e)],
                          ),
                        ),
                      )
                      .toList(),
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: details.location,
                    builder: (ctx) => Icon(
                      ChapChap.pin,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                  ),
                ],
                polygonOptions: const PolygonOptions(
                    borderColor: Colors.blueAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 3),
                builder: (context, markers) {
                  return FloatingActionButton(
                    onPressed: null,
                    child: Text(markers.length.toString()),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
