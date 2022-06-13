import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/location.dart';
import '../../../styles/icons/chap_chap_icons.dart';

class OSM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: Provider.of<AppData>(context).mapController,
      options: MapOptions(
        center: Provider.of<AppData>(context).location,
        zoom: 17,
        onMapCreated: (controller) =>
            Provider.of<AppData>(context).initialization(),
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
              point: Provider.of<AppData>(context).location,
              builder: (ctx) => const Icon(ChapChap.pin),
            ),
          ],
        ),
      ],
    );
    // return Consumer<AppData>(
    //   builder: (context, value, child) {
    //     return FlutterMap(
    //       options: MapOptions(
    //         center: value.location,
    //         zoom: 17,
    //       ),
    //       layers: [
    //         TileLayerOptions(
    //           urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    //           subdomains: ['a', 'b', 'c'],
    //           attributionBuilder: (_) {
    //             return const Text("© OpenStreetMap contributors");
    //           },
    //         ),
    //         MarkerLayerOptions(
    //           markers: [
    //             Marker(
    //               width: 40.0,
    //               height: 40.0,
    //               point: value.location,
    //               builder: (ctx) => const Icon(ChapChap.pin),
    //             ),
    //           ],
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
