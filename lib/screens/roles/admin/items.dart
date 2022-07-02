import 'package:client/router/roles.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/styles/icons/chap_chap_icons.dart';
import 'package:client/styles/ui/colors.dart';
import 'package:flutter/material.dart';

class AddItem extends StatelessWidget {
  AddItem({
    required this.itemName,
    super.key,
  });

  final String itemName;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: pageConstraints,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 56, horizontal: 30),
        backgroundColor: AppColors.bgDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              "Add $itemName",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: "SF Pro Rounded",
                fontWeight: FontWeight.w700,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildHeader(),
                  itemDescription(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createItem({
    required BuildContext context,
    required String itemName,
    required String itemAddress,
    String? itemDescription,
  }) {}

  ElevatedButton buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          createItem(
            context: context,
            itemName: _nameController.text,
            itemAddress: _addressController.text,
            itemDescription: _descriptionController.text,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 124),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Text(
        "Register",
        style: TextStyle(
          fontFamily: "SF Pro Rounded",
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Row buildHeader() {
    void getGarageImage() {}

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getGarageImage,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const FlutterLogo(size: 78),
            ),
            const SizedBox(height: 5),
            Text(
              "$itemName Image",
              style: const TextStyle(
                color: Color(0xff6a6a6a),
                fontSize: 15,
              ),
            ),
          ],
        ),
        authInput(
          hint: "$itemName Name",
          controller: _nameController,
          focusNode: _nameFocusNode,
          validator: (value) => Validator.validateName(name: value),
        )
      ],
    );
  }

  Column itemDescription() {
    return Column(
      children: [
        Text(
          "$itemName Description",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: _descriptionController,
            focusNode: _descriptionFocusNode,
            validator: null,
            textAlignVertical: TextAlignVertical.center,
            obscureText: false,
            keyboardType: null,
            style: const TextStyle(
              fontFamily: "SF Pro Rounded",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
            decoration: InputDecoration(
              filled: true,
              isCollapsed: true,
              prefixIcon: null,
              suffixIcon: null,
              contentPadding: const EdgeInsets.fromLTRB(30, 17, 0, 17),
              fillColor: AppColors.input,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              hintText: null,
              helperText: null,
              helperStyle: const TextStyle(
                fontFamily: "SF Pro Rounded",
                fontSize: 10,
                color: AppColors.error,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        )
      ],
    );
  }

  Column itemAddress() {
    return Column(
      children: [
        Text(
          "$itemName Address",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SF Pro Rounded",
            fontWeight: FontWeight.w600,
          ),
        ),
        authInput(
          hint: "Add your Location",
          controller: _addressController,
          focusNode: _addressFocusNode,
          suffix: const Icon(
            ChapChap.pin,
            size: 20,
          ),
          validator: (value) => Validator.validateAddress(address: value),
        )
      ],
    );
  }
}

class AddAdmin extends StatelessWidget {
  const AddAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return AddItem(itemName: "Admin");
  }
}

class AddGarage extends StatelessWidget {
  const AddGarage({super.key});

  @override
  Widget build(BuildContext context) {
    return AddItem(itemName: "Garage");
  }
}
