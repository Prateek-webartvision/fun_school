// ignore_for_file: prefer_const_constructors

import 'package:fun_school/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:intl/intl.dart';

import '../../../style/assets.dart';
import '../../../style/color.dart';
import '../../../utils/helper.dart';

class GroupTabTile extends StatelessWidget {
  const GroupTabTile({
    super.key,
    this.onItemClick,
    required this.title,
    required this.description,
    required this.totalMembers,
    required this.dateJoined,
  });
  final String title;
  final String description;
  final String totalMembers;
  final String dateJoined;
  final Function()? onItemClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: AppShadow.mainShadow,
      ),
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
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                Text(
                  description,
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
                        totalMembers,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
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
                        // "Joined on May 20, 2023",
                        "Created on ${DateFormat("MMM dd, yyyy").format(getDateFromTimestemp10(dateJoined))}",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
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
