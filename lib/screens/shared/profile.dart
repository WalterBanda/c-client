import 'package:flutter/material.dart';

import '../../styles/index.dart';
import '../../styles/ui/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 130, left: 27, right: 27),
      maintainBottomViewPadding: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 320, maxWidth: 680),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bg.withOpacity(0.2),
                      ),
                      child: const Icon(ChapChap.user, size: 50),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Username",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Currently you have no description about you, add your description about you so that other people can know about you",
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
                  children: [
                    const Text(
                      "Your Activity",
                      style: TextStyle(
                        fontFamily: "SF Pro Rounded",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
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
                onPressed: () {},
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
