// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class ExamDetailsTile extends StatelessWidget {
  const ExamDetailsTile({
    super.key,
    required this.completeState,
    this.onClick,
  });

  final int completeState;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 24,
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.black),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "Question $completeState/7",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.textFeildBorderColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "1 point",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            8.height,
            Text(
              "Of the following, which best describes a variable?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
