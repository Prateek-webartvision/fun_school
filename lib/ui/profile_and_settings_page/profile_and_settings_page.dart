// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

class ProfileAndSettings extends StatelessWidget {
  const ProfileAndSettings({super.key});

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
                      // BoxShadow(
                      //   color: Color(0x1A101828),
                      //   offset: Offset(1, 3),
                      // ),
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
                  "John Doe",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          16.height,
          _MyTiles(
            leadingIcon: Icons.email,
            title: "Email",
            tralingText: "john.doe@gmail.com",
          ),
          Divider(height: 0),
          _MyTiles(
            leadingIcon: Icons.person,
            title: "Username",
            tralingText: "john.doe",
          ),
          Divider(height: 0),
          _MyTiles(
            leadingIcon: Icons.lock,
            title: "Change Password",
          ),
        ],
      ),
    );
  }
}

class _MyTiles extends StatelessWidget {
  const _MyTiles({
    super.key,
    required this.title,
    this.tralingText,
    this.leadingIcon,
    this.color,
  });

  final String title;
  final String? tralingText;
  final IconData? leadingIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(color: AppColor.white),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          (leadingIcon != null)
              ? Icon(
                  // Icons.email,
                  leadingIcon,
                  color: color ?? context.theme.primaryColor,
                  size: 18,
                )
              : 0.width,
          (leadingIcon != null) ? 6.width : 0.width,
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
          (tralingText != null) ? 10.width : 0.width,
          (tralingText != null)
              ? Expanded(
                  child: Text(
                    tralingText!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.end,
                  ),
                )
              : 0.width,
          6.width,
          Icon(
            Icons.navigate_next_rounded,
            size: 20,
          ),
        ],
      ),
    );
  }
}
