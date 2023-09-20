// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class GradeTile extends StatelessWidget {
  const GradeTile({
    super.key,
    required this.title,
    required this.time,
    required this.questions,
    this.grade,
    this.onStartClick,
  });
  final String title;
  final Duration time;
  final int questions;
  final String? grade;
  final Function()? onStartClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
          Text.rich(
            TextSpan(text: AppUtils.getReadableDuration(time), children: [
              TextSpan(text: " "),
              TextSpan(text: "•"),
              TextSpan(text: " "),
              TextSpan(text: "$questions Questions"),
            ]),
            style: TextStyle(
              fontSize: 16,
              color: AppColor.white,
            ),
          ),
          12.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Receive grade",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.white,
                ),
              ),
              Text(
                "TO PASS 75% or higher",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grade",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.white,
                ),
              ),
              Text(
                grade ?? "---",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
          12.height,
          GestureDetector(
            onTap: onStartClick,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColor.textFeildBorderColor.withOpacity(0.4),
                  )),
              alignment: Alignment.center,
              child: Text(
                "Start",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColor.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
