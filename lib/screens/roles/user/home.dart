import 'dart:async';

import 'package:client/core/models/garage.dart';
import 'package:client/screens/roles/admin/items.dart';
import 'package:client/screens/roles/user/osm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/location.dart';
import '../../../router/roles.dart';
import '../../../styles/icons/chap_chap_icons.dart';
import '../../../styles/ui/colors.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  static const String id = "user";

  void _getLocation(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false)
        .getUserLocation(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OSM(),
        mapUtils(
          context: context,
          callback: () => _getLocation(context),
        ),
      ],
    );
  }
}

class SearchOverlay extends StatelessWidget {
  SearchOverlay({Key? key}) : super(key: key);

  Stream<QuerySnapshot<Garage>> getGarages() {
    return FirebaseFirestore.instance
        .collection('garage')
        .withConverter(
          fromFirestore: Garage.fromFirestore,
          toFirestore: (Garage userModel, _) => userModel.toFirestore(),
        )
        .snapshots();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          searchBuilder(),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: getGarages(),
              builder:
                  (context, AsyncSnapshot<QuerySnapshot<Garage>> snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    "Search for nearby Garages",
                    style: TextStyle(
                      fontFamily: "SF Pro Rounded",
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.error == true) {
                  const Text(
                    "Unable to search for nearby Garages",
                    style: TextStyle(
                      fontFamily: "SF Pro Rounded",
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  );
                }

                List<Garage> data = snapshot.data!.docs
                    .where((gr) =>
                        gr.data().name.contains(searchController.value.text))
                    .map((QueryDocumentSnapshot<Garage> garageSnapshot) =>
                        garageSnapshot.data())
                    .toList();

                return ListView.separated(
                  padding: const EdgeInsets.all(5),
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemCount: data.length,
                  itemBuilder: (_, i) {
                    return RoundedTile(
                      label: data[i].name,
                      avatar: Image.network(data[i].image),
                      icon: const Icon(ChapChap.add),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  TextField searchBuilder() {
    return TextField(
      controller: searchController,
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
    );
  }
}

Positioned mapUtils(
    {required BuildContext context, required VoidCallback callback}) {
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
              onPressed: callback,
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
              decoration: BoxDecoration(
                color: AppColors.bgDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onTap: () {
                  showDialog(
                      context: context, builder: (context) => SearchOverlay());
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
