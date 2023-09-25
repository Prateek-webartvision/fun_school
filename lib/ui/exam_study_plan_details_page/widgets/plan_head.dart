// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../style/theme.dart';

class PlanHeadTile extends StatelessWidget {
  const PlanHeadTile({
    super.key,
    required this.title,
    required this.date,
    required this.progressHour,
    required this.progress,
  });
  final String title;
  final DateTime date;
  final int progressHour, progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: AppShadow.boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            // "JAMB 2023",
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          6.height,
          Text.rich(
            TextSpan(text: "Date : ", children: [
              TextSpan(
                text: DateFormat("MMMM d, yyy").format(date),
              ),
            ]),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          6.height,
          Text.rich(
            TextSpan(text: "Progress : ", children: [
              TextSpan(text: "$progressHour hours ("),
              TextSpan(text: "$progress% completed", style: TextStyle(color: AppColor.mainColor)),
              TextSpan(text: ")"),
            ]),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          6.height,
          LinearProgressIndicator(
            minHeight: 6,
            borderRadius: BorderRadius.circular(6),
            value: progress / 100,
          )
        ],
      ),
    );
  }
}
