import 'package:client/core/providers/appdata.dart';
import 'package:client/styles/ui/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// 🏘️ Local imports
import '../../../core/models/user.dart';
import '../../../router/roles.dart';
import '../../../styles/icons/chap_chap_icons.dart';
import '../admin/home.dart';
import '../admin/items.dart';
import '../user/home.dart';

class GarageHome extends StatelessWidget {
  const GarageHome({Key? key}) : super(key: key);

  static const String id = "garage";

  Widget _buildStats({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    required double cummulative,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.bgDark,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.157),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  height: 16,
                  width: 40,
                  child: SvgPicture.asset(
                    cummulative.isNegative
                        ? "assets/images/res/graph_down.svg"
                        : "assets/images/res/graph_up.svg",
                    height: 16,
                    width: 60,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: 6,
                  child: SvgPicture.asset(
                    cummulative.isNegative
                        ? "assets/images/res/loss.svg"
                        : "assets/images/res/gain.svg",
                    height: 6,
                    width: 6,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text(
                  "${cummulative.isNegative ? '' : '+'}$cummulative%",
                  style: TextStyle(
                    color: cummulative.isNegative
                        ? const Color.fromRGBO(226, 80, 122, 1)
                        : const Color.fromRGBO(80, 226, 193, 1),
                    fontSize: 11,
                  ),
                )
              ],
            )
          ],
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
                      "Earnings Stats",
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStats(
                          context: context,
                          label: "Daily",
                          cummulative: -5.23,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => const SearchOverlay(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildStats(
                          context: context,
                          label: "Weekly",
                          cummulative: 39.69,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => const SearchOverlay(),
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
                      "Service Requests",
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 27),
                    Expanded(
                      child: TabbedLayout(
                        tabLabel: ["New Requests", "Completed"],
                        tabs: [NewRequests(), CompletedRequests()],
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

class NewRequests extends StatelessWidget {
  const NewRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, instance, child) => ListView.separated(
        padding: const EdgeInsets.all(5),
        separatorBuilder: (_, __) => const SizedBox(height: 15),
        itemCount: instance.serviceRequestN.length,
        itemBuilder: (_, i) => RoundedTile(
          label: getUserDetails(instance.serviceRequestN[i].userId)?.name,
          avatar: Image.network(
            getUserDetails(instance.serviceRequestN[i].userId)?.profilePhoto ??
                UserModel.clear().profilePhoto,
          ),
          icon: const Icon(ChapChap.add),
          onPressed: () {
            instance.updateServiceRequest(
              completed: false,
              uid: instance.serviceRequestN[i].userId,
            );
          },
        ),
      ),
    );
  }
}

UserModel? getUserDetails(userId) {
  UserModel? res;
  FirebaseFirestore.instance
      .collection("users")
      .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel userModel, _) => userModel.toFirestore())
      .doc(userId)
      .get()
      .then((value) {
    res = value.data();
  });
  return res;
}

class CompletedRequests extends StatelessWidget {
  const CompletedRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, instance, child) => ListView.separated(
        padding: const EdgeInsets.all(5),
        separatorBuilder: (_, __) => const SizedBox(height: 15),
        itemCount: instance.serviceRequestC.length,
        itemBuilder: (_, i) => RoundedTile(
          label: getUserDetails(instance.serviceRequestC[i].userId)?.name,
          avatar: Image.network(
            getUserDetails(instance.serviceRequestC[i].userId)?.profilePhoto ??
                UserModel.clear().profilePhoto,
          ),
          icon: const Icon(ChapChap.info),
        ),
      ),
    );
  }
}
