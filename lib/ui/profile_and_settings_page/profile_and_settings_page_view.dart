// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/assets.dart';
import '../../style/color.dart';
import 'profile_and_settings_page_state.dart';
import 'widgets/profile_option_tile.dart';

class ProfileAndSettingsView extends StatefulWidget {
  const ProfileAndSettingsView({super.key});

  @override
  State<ProfileAndSettingsView> createState() => _ProfileAndSettingsViewState();
}

class _ProfileAndSettingsViewState extends ProfileAndSettingsState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 116,
            decoration: BoxDecoration(color: AppColor.white),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(48),
                    border: Border.all(color: AppColor.softBorderColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0F101828),
                        offset: Offset(1, 2),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(AppAssets.logo),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                12.height,
                Text(
                  // "John Doe",
                  "${currentUser?.userName}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          16.height,
          ProfileOptionTile(
            leadingIcon: Icons.email,
            title: "Email",
            // tralingText: "john.doe@gmail.com",
            tralingText: currentUser?.userEmail ?? "NA",
          ),
          Divider(height: 0),
          ProfileOptionTile(
            leadingIcon: Icons.person,
            title: "Username",
            // tralingText: "john.doe",
            tralingText: "${currentUser?.userName}",
          ),
          Divider(height: 0),
          ProfileOptionTile(
            leadingIcon: Icons.lock,
            title: "Change Password",
          ),

          //
          10.height,
          ProfileOptionTile(
            leadingIcon: Icons.download_for_offline_rounded,
            title: "Download Setting",
          ),
          Divider(height: 0),
          ProfileOptionTile(
            leadingIcon: Icons.filter_list,
            title: "Adjust Display",
          ),
          Divider(height: 0),
          ProfileOptionTile(
            leadingIcon: Icons.notifications_rounded,
            title: "Push notifications",
          ),
          Divider(height: 0),
          ProfileOptionTile(
            leadingIcon: Icons.date_range_rounded,
            title: "Sync to my calendar",
          ),
          Divider(height: 0),
          ProfileOptionTile(
            leadingIcon: Icons.help,
            title: "Help Centre",
          ),
          Divider(height: 0),
          ProfileOptionTile(
            leadingIcon: Icons.info,
            title: "About",
          ),
          10.height,
          ProfileOptionTile(
            color: Color(0xffFF0000),
            leadingIcon: Icons.delete,
            title: "Delete account",
          ),
          10.height,
          ProfileOptionTile(
            title: "Sign Out",
            onClick: logOut,
          ),
        ],
      ),
    );
  }
}
