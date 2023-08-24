// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/assets.dart';
import '../../../style/color.dart';

class GroupTabTile extends StatelessWidget {
  const GroupTabTile({
    super.key,
    this.onItemClick,
  });
  final Function()? onItemClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(9), boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
          color: Color(0xFF101828).withOpacity(0.06),
        ),
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 0,
          color: Color(0xFF101828).withOpacity(0.1),
        ),
      ]),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onItemClick,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Physics Enthusiasts",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Dive into the world of physics, from quantum mechanics to classical dynamics.",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                12.height,
                Row(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppAssets.svg.parentFillIcon),
                      4.width,
                      Text(
                        "1200",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  10.width,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppAssets.svg.calendarlineIcon),
                      4.width,
                      Text(
                        "Joined on May 20, 2023",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
