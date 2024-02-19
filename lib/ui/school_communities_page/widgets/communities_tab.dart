// ignore_for_file: prefer_const_constructors

import 'package:fun_school/style/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../controllers/communities_tab_controller.dart';

class CommunitiesTabSelector extends StatelessWidget {
  const CommunitiesTabSelector({
    super.key,
    required this.controller,
  });
  final CommunitiesTabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border(
          top: BorderSide(color: AppColor.softBorderColor),
          bottom: BorderSide(color: AppColor.softBorderColor),
        ),
      ),
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Row(
            children: [
              tab(
                title: "Discussions",
                color: colorShifter(itemId: 0),
                svgIcon: AppAssets.svg.weChatFillIcon,
                onTab: () {
                  controller.index = 0;
                },
              ),
              VerticalDivider(color: AppColor.softBorderColor, width: 1),
              tab(
                title: "Groups",
                color: colorShifter(itemId: 1),
                svgIcon: AppAssets.svg.recordCircleIcon,
                onTab: () {
                  controller.index = 1;
                },
              ),
              VerticalDivider(color: AppColor.softBorderColor, width: 1),
              tab(
                title: "Messages",
                color: colorShifter(itemId: 2),
                svgIcon: AppAssets.svg.groupIcon,
                onTab: () {
                  controller.index = 2;
                },
              )
            ],
          );
        },
      ),
    );
  }

  Color colorShifter({required int itemId}) {
// controller Colors.black
    if (controller.currentIndex == itemId) {
      return AppColor.mainColor;
    } else {
      return Colors.black;
    }
  }

  Widget tab({
    required String title,
    required Color color,
    required String svgIcon,
    required Function() onTab,
  }) =>
      Expanded(
        child: Container(
          color: AppColor.white,
          height: double.maxFinite,
          alignment: Alignment.center,
          child: InkWell(
            onTap: onTab,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(
                //   icon,
                //   color: color,
                //   size: 16,
                // ),
                SvgPicture.asset(svgIcon),
                4.width,
                Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color),
                ),
              ],
            ),
          ),
        ),
      );
}
