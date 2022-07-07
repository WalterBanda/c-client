import 'package:client/core/providers/appdata.dart';
import 'package:client/core/providers/user.dart';
import 'package:client/router/roles.dart';
import 'package:client/styles/ui/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/user.dart';
import '../../../styles/icons/chap_chap_icons.dart';
import 'items.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  static const String id = "admin";

  Widget _buildAddItem({
    required BuildContext context,
    required String label,
    required GestureTapCallback onPressed,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: DottedBorder(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          borderType: BorderType.RRect,
          dashPattern: const [4, 4],
          radius: const Radius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: "SF Pro Rounded",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 130, left: 36, right: 36),
      maintainBottomViewPadding: false,
      child: Center(
        child: ConstrainedBox(
          constraints: pageConstraints,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Admin Tasks",
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAddItem(
                          context: context,
                          label: "+ Add Garage",
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AddGarage(
                              admin: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildAddItem(
                          context: context,
                          label: "+ Add Admin",
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AddAdmin(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "User Verification Requests",
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 27),
                    Expanded(
                      child: TabbedLayout(
                        tabLabel: ["Garage Requests", "Admin Requests"],
                        tabs: [
                          GarageRequestsTab(),
                          AdminRequests(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabbedLayout extends StatelessWidget {
  const TabbedLayout({
    Key? key,
    required this.tabLabel,
    required this.tabs,
  }) : super(key: key);

  final List<String> tabLabel;
  final List<Widget> tabs;

  List<Widget> _buildTabsLabel() => tabLabel
      .map(
        (e) => Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          child: Text(
            e,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "SF Pro Rounded",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromRGBO(0, 0, 0, 0.1),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              labelColor: AppColors.success,
              unselectedLabelColor: const Color(0x42000000),
              tabs: _buildTabsLabel(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(child: TabBarView(children: tabs)),
        ],
      ),
    );
  }
}

class GarageRequestsTab extends StatelessWidget {
  const GarageRequestsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(5),
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemCount: Provider.of<AppData>(context).garageRequest.length,
      itemBuilder: (_, i) => RoundedTile(
          label: Provider.of<AppData>(context).garageRequest[i].garage.name,
          avatar: Image.network(
              Provider.of<AppData>(context).garageRequest[i].garage.image),
          icon: const Icon(ChapChap.add),
          onPressed: () {
            Provider.of<AppData>(context, listen: false).createGarage(
              garage: Provider.of<AppData>(context).garageRequest[i].garage,
            );

            updateUserDetails(
              userId:
                  Provider.of<AppData>(context).garageRequest[i].garage.userUid,
              role: Roles.garage,
            );
          }),
    );
  }
}

updateUserDetails({required String userId, required Roles role}) {
  FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel userModel, _) => userModel.toFirestore())
      .update(
    {
      "roles": <Roles>[role].toRolesString()
    },
  );
}

class AdminRequests extends StatelessWidget {
  const AdminRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(5),
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemCount: Provider.of<AppData>(context).adminRequest.length,
      itemBuilder: (_, i) => RoundedTile(
          label: Provider.of<AppData>(context).adminRequest[i].user!.name,
          avatar: Image.network(
            Provider.of<AppData>(context).adminRequest[i].user!.profilePhoto,
          ),
          icon: const Icon(ChapChap.add),
          onPressed: () => updateUserDetails(
                userId:
                    Provider.of<AppData>(context).adminRequest[i].user!.uid!,
                role: Roles.admin,
              )),
    );
  }
}
