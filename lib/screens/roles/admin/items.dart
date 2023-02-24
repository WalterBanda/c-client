import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../core/models/garage.dart';
import '../../../core/models/user.dart';
import '../../../core/providers/appdata.dart';
import '../../../router/roles.dart';
import '../../auth/login.dart';
import '../../../styles/icons/chap_chap_icons.dart';
import '../../../styles/ui/colors.dart';
import 'home.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: pageConstraints,
        child: Dialog(
          backgroundColor: AppColors.bgDark,
          insetPadding:
              const EdgeInsets.only(top: 24, bottom: 24, right: 10, left: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddAdmin extends StatefulWidget {
  const AddAdmin({super.key});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Administrator ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            onChanged: (value) => runFilter(value),
            style: const TextStyle(
              fontFamily: "SF Pro Rounded",
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              filled: true,
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
              hintText: "Search for User",
            ),
          ),
          const SizedBox(height: 25),
          Expanded(flex: 4, child: getUsers()),
        ],
      ),
    );
  }

  late List<Garage> users = [];

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('garage')
        .withConverter(
          fromFirestore: Garage.fromFirestore,
          toFirestore: (Garage userModel, _) => userModel.toFirestore(),
        )
        .snapshots()
        .listen((val) {
      setState(() {
        users = val.docs
            .map((QueryDocumentSnapshot<Garage> garageSnapshot) =>
                garageSnapshot.data())
            .toList();
      });
    });
  }

  void runFilter(String enteredKeyword) {
    List<Garage> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = users;
    } else {
      results = users
              .where((garage) => garage.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList()
              .isEmpty
          ? users
          : users
              .where((garage) => garage.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
              .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      users = results;
    });
  }

  Widget getUsers() {
    return ListView.separated(
      padding: const EdgeInsets.all(5),
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemCount: users.length,
      itemBuilder: (_, i) {
        return RoundedTile(
          label: users[i].name,
          avatar: Image.network(users[i].image),
          icon: const Icon(ChapChap.add),
          onPressed: () =>
              updateUserDetails(userId: users[i].userUid, role: Roles.admin),
        );
      },
    );
  }
}

class RoundedTile extends StatelessWidget {
  const RoundedTile({
    Key? key,
    this.label,
    required this.icon,
    required this.avatar,
    this.onPressed,
  }) : super(key: key);

  final String? label;
  final Widget icon;
  final Widget avatar;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.bgDark,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.bgDark,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: avatar,
          ),
          Expanded(
            child: Text(
              label ?? '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(6),
            ),
            child: icon,
          ),
        ],
      ),
    );
  }
}

class AddGarage extends StatelessWidget {
  AddGarage({required this.admin, super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final ValueNotifier<Address?> _addressController = ValueNotifier(null);
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _userFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final bool admin;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Garage",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: "SF Pro Rounded",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 25),
              garageInfo(),
              const SizedBox(height: 25),
              garageDescription(),
              const SizedBox(height: 25),
              garageAddress(context),
              const SizedBox(height: 25),
              garageAdminUser(),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (admin) {
                      Provider.of<AppData>(context, listen: false)
                          .createGarage(
                        garage: Garage(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          address: _addressController.value!,
                          userUid: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      )
                          .then(
                        (value) {
                          _addressController.dispose();
                          _addressTextController.dispose();
                          _userController.dispose();
                          _descriptionController.dispose();
                          _nameController.dispose();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      );
                    } else {
                      Provider.of<AppData>(context, listen: false)
                          .createGarageRequest(
                        payload: GarageRequests(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          garage: Garage(
                            name: _nameController.text,
                            description: _descriptionController.text,
                            address: _addressController.value!,
                            userUid: FirebaseAuth.instance.currentUser!.uid,
                          ),
                        ),
                      )
                          .then(
                        (value) {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Request for Access",
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  garageAdminUser() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Garage Admin User",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _userController,
          focusNode: _userFocusNode,
          style: const TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
          decoration: InputDecoration(
            hintText: "User responsible for the garage",
            filled: true,
            isCollapsed: true,
            prefixIcon: const Icon(ChapChap.user, size: 20),
            contentPadding:
                const EdgeInsets.only(top: 24, bottom: 24, left: 15, right: 10),
            fillColor: AppColors.input,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  garageAddress(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Garage Address",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _addressTextController,
          focusNode: _addressFocusNode,
          validator: (value) =>
              Validator.validateAddress(address: _addressController.value),
          onTap: () => showDialog(
            context: context,
            builder: (context) => AppDialog(
              child: FlutterLocationPicker(
                initZoom: 11,
                minZoomLevel: 5,
                maxZoomLevel: 16,
                trackMyPosition: true,
                selectLocationButtonText: 'Select Garage Location',
                selectLocationButtonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.primary),
                ),
                markerIcon: ChapChap.garage,
                markerIconColor: AppColors.primary,
                searchBarBackgroundColor: AppColors.input,
                zoomButtonsBackgroundColor: AppColors.primary,
                locationButtonBackgroundColor: AppColors.primary,
                onPicked: (pickedData) {
                  _addressTextController.text = pickedData.address;
                  Navigator.of(context, rootNavigator: true).pop();
                  _addressController.value = Address(
                      name: pickedData.address.toString(),
                      position: LatLng(pickedData.latLong.latitude,
                          pickedData.latLong.longitude));
                },
              ),
            ),
          ),
          style: const TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
          decoration: InputDecoration(
            hintText: "Add your Address",
            filled: true,
            isCollapsed: true,
            suffixIcon: const Icon(ChapChap.location, size: 20),
            contentPadding:
                const EdgeInsets.only(top: 24, bottom: 24, left: 15),
            fillColor: AppColors.input,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  garageDescription() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Garage Description",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _descriptionController,
          focusNode: _descriptionFocusNode,
          validator: (value) =>
              Validator.validateName(name: value!, label: 'Garage Description'),
          minLines: 4,
          maxLines: 5,
          style: const TextStyle(
            fontFamily: "SF Pro Rounded",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
          decoration: InputDecoration(
            filled: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.fromLTRB(15, 20, 5, 20),
            fillColor: AppColors.input,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Row garageInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 84,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.bgDark,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.149),
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: getImage(),
            ),
            const SizedBox(height: 5),
            const Text(
              "Garage Image",
              style: TextStyle(
                color: Color.fromRGBO(106, 106, 106, 1),
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: _nameController,
            focusNode: _nameFocusNode,
            validator: (value) =>
                Validator.validateName(name: value!, label: 'Garage Name'),
            style: const TextStyle(
              fontFamily: "SF Pro Rounded",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
            decoration: InputDecoration(
              filled: true,
              hintText: "Garage Name",
              isCollapsed: true,
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
              fillColor: AppColors.input,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

getImage() {
  return Image.asset(
    'assets/images/img/garage.png',
    errorBuilder: (_, __, ___) {
      return const FlutterLogo(size: 78);
    },
  );
}
