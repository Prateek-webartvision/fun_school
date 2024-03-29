// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../style/color.dart';
import '../../../style/theme.dart';

class ExamStudyPlanTile extends StatelessWidget {
  const ExamStudyPlanTile({
    super.key,
    required this.title,
    required this.date,
    required this.progress,
    this.onClick,
    required this.examHour,
  });

  final String title;
  final DateTime date;
  final int progress;
  final int examHour;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
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
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
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
            Text.rich(
              TextSpan(text: "Progress : ", children: [
                TextSpan(text: "$examHour hours ("),
                TextSpan(text: "$progress% completed", style: TextStyle(color: AppColor.mainColor)),
                TextSpan(text: ")"),
              ]),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
