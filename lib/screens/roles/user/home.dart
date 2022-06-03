import 'package:flutter/material.dart';

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
          height: 100,
          bottom: 30,
          left: 10,
          right: 10,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 320, maxWidth: 680),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                width: 300,
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
    return Container(
      color: const Color.fromRGBO(196, 196, 196, 1),
      child: const Center(
        child: Text("Unable to load a map, \n Please refresh"),
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
        constraints: const BoxConstraints(minWidth: 320, maxWidth: 680),
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
