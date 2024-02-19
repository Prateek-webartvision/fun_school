// ignore_for_file: prefer_const_constructors

import 'package:fun_school/style/theme.dart';
import 'package:flutter/material.dart';

import '../../../style/color.dart';

class MeetingsTile extends StatelessWidget {
  const MeetingsTile({
    super.key,
    required this.title,
    required this.time,
    required this.body,
    required this.count,
    this.duration,
    this.onItemClick,
  });
  final String title;
  final String time;
  final String body;
  final String count;
  final String? duration;
  final Function()? onItemClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: AppShadow.mainShadow),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: InkWell(
        onTap: onItemClick,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              time,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
            Text(
              body,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            ),
            if (duration != null)
              Text(
                duration ?? "",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            Text(
              count,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.mainColor),
            ),
          ],
        ),
      ),
    );
  }
}
