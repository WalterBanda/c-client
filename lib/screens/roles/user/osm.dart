import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

// 🏘️ Local imports
import '../../../core/providers/appdata.dart';
import '../../../core/providers/location.dart';

class OSM extends StatelessWidget {
  OSM({super.key});

  final MapController controller = MapController();

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
                maxClusterRadius: 60,
                size: const Size(40, 40),
                fitBoundsOptions: const FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: Provider.of<AppData>(context).garages.map((garage) {
                  return Marker(
                    width: 40.0,
                    height: 40.0,
                    point: garage.address.position,
                    builder: (ctx) => const Icon(
                      Icons.garage_rounded,
                    ),
                  );
                }).toList(),
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
