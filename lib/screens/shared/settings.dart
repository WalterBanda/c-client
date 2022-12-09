import 'package:client/core/models/garage.dart';
import 'package:client/core/models/user.dart';
import 'package:client/core/providers/appdata.dart';
import 'package:client/screens/auth/onboarding.dart';
import 'package:client/screens/roles/admin/items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:provider/provider.dart';

import '../../core/providers/user.dart';
import '../../router/roles.dart';
import '../../styles/icons/chap_chap_icons.dart';
import '../../styles/ui/colors.dart';
import '../auth/login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 140, left: 36, right: 36),
      maintainBottomViewPadding: false,
      child: Center(
        child: ConstrainedBox(
          constraints: pageConstraints,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildEdit(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => changeProfilePic(context: context),
                  ),
                  icon: Icons.camera_alt_rounded,
                  child: CircleAvatar(
                    minRadius: 30,
                    maxRadius: 60,
                    backgroundImage: NetworkImage(
                        Provider.of<UserProvider>(context).user.profilePhoto),
                  ),
                ),
                const SizedBox(height: 24),
                buildEdit(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => EditDetails(context: context),
                  ),
                  icon: Icons.edit_note_rounded,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Provider.of<UserProvider>(context).user.name,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "SF Pro Rounded",
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        Provider.of<UserProvider>(context).user.description,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: const TextStyle(
                          fontFamily: "SF Pro Rounded",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Change Your Roles",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAddItem(
                      context: context,
                      label: "+ Create Garage",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AddGarage(
                          admin: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildAddItem(
                      context: context,
                      label: "+ Request Admin Role",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => RequestAdminAccess(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildEdit({
    required IconData icon,
    required Widget child,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          child,
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: AppColors.bgDark,
                child: Icon(icon),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddItem({
    required BuildContext context,
    required String label,
    required GestureTapCallback onPressed,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: DottedBorder(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          borderType: BorderType.RRect,
          dashPattern: const [4, 4],
          radius: const Radius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "SF Pro Rounded",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget changeProfilePic({required BuildContext context}) {
    return AppDialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Change profile photo",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  minRadius: 30,
                  maxRadius: 60,
                  backgroundImage: NetworkImage(
                    Provider.of<UserProvider>(context).user.profilePhoto,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Profile pic Url",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) => Validator.validateName(name: value!),
              style: const TextStyle(
                fontFamily: "SF Pro Rounded",
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
              decoration: InputDecoration(
                filled: true,
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                fillColor: AppColors.input,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                helperStyle: const TextStyle(
                  fontFamily: "SF Pro Rounded",
                  fontSize: 10,
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Update Profile Pic",
                    style: TextStyle(
                      fontFamily: "SF Pro Rounded",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RequestAdminAccess extends StatelessWidget {
  RequestAdminAccess({
    Key? key,
  }) : super(key: key);

  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                "Request Admin Access",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: "SF Pro Rounded",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Reason for Request",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "SF Pro Rounded",
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                minLines: 4,
                maxLines: 5,
                validator: (val) => Validator.validateName(name: val!),
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<AppData>(context, listen: false)
                        .createAdminRequest(
                          payload: AdminRequests(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            description: descriptionController.text,
                          ),
                        )
                        .then(
                          (value) =>
                              Navigator.of(context, rootNavigator: true).pop(),
                        );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditDetails extends StatelessWidget {
  EditDetails({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<Address?> _addressController = ValueNotifier(null);
  final TextEditingController _addressTextController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: SingleChildScrollView(
        child: Column(children: [
          Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              authInput(
                hint: "Your Username",
                controller: _nameController,
                focusNode: _nameFocusNode,
                inputType: TextInputType.name,
                // validator: (value) => Validator.validateName(name: value),
                prefix: const Icon(
                  ChapChap.user,
                  size: 15,
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
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
                  hintText: "Enter your Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              authInput(
                hint: "Enter your Email",
                controller: _emailController,
                focusNode: _emailFocusNode,
                inputType: TextInputType.emailAddress,
                // validator: (value) => Validator.validateEmail(email: value),
                prefix: const Icon(
                  Icons.email_rounded,
                  size: 15,
                ),
              ),
              const SizedBox(height: 15),
              authInput(
                hint: "Enter your Phone Number",
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                inputType: TextInputType.phone,
                // validator: (value) => Validator.validatePhone(phone: value),
                prefix: const Icon(
                  Icons.phone_rounded,
                  size: 15,
                ),
              ),
              const SizedBox(height: 15),
              authInput(
                hint: "Enter your Address",
                controller: _addressTextController,
                focusNode: _addressFocusNode,
                inputType: TextInputType.streetAddress,
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
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
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
                prefix: const Icon(
                  ChapChap.location,
                  size: 15,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  userUpdate(
                    context: context,
                    name: _nameController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    description: _descriptionController.text,
                    address: _addressController.value,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Update Info",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

void userUpdate({
  required BuildContext context,
  required String? name,
  required Address? address,
  required String? phone,
  required String? description,
  required String? email,
}) {
  UserModel user = Provider.of<UserProvider>(context, listen: false).user;

  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    "name": name ?? user.name,
    "email": email ?? user.email,
    "phone": phone ?? user.phone,
    "address":
        address != null ? address.toFirestore() : user.address.toFirestore(),
    "description": description ?? user.description,
  });
}
