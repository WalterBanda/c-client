import 'package:flutter/material.dart';

import '../../../router/roles.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  static const String id = "user";

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MapLayer(),
      ],
    );
  }
}

class MapLayer extends StatefulWidget {
  const MapLayer({Key? key}) : super(key: key);

  @override
  State<MapLayer> createState() => _MapLayerState();
}

class _MapLayerState extends State<MapLayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(196, 196, 196, 1),
      child: const Center(
        child: Text("Unable to load a map, \n Please refresh"),
      ),
    );
  }
}
