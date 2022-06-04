import 'package:client/router/roles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/routes/router.dart';
import '../../core/routes/routes.dart';
import '../../styles/ui/colors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 130, left: 27, right: 27),
      maintainBottomViewPadding: false,
      child: Center(
        child: ConstrainedBox(
          constraints: pageConstraints,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      minRadius: 30,
                      maxRadius: 80,
                      backgroundImage: NetworkImage(
                          FirebaseAuth.instance.currentUser!.photoURL ??
                              "https://ui-avatars.com/api/?name=username"),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      firebaseAuth.currentUser!.displayName.toString(),
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
                    const Text(
                      // FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(["description"]).toString(),
                      "Description",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: const [
                    Text(
                      "Your Activity",
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No Activity Currently, Book a garage and your activity will be shown here",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await firebaseAuth.signOut().then(
                        (value) => GlobalNavigator.router.currentState!
                            .pushReplacementNamed(GlobalRoutes.auth),
                      );
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 124),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: "SF Pro Rounded",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
