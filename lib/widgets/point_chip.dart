// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../style/color.dart';

class PointChip extends StatelessWidget {
  const PointChip({
    super.key,
    this.point = 1,
  });
  final int? point;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.scaffoldBg,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColor.textFeildBorderColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        "$point point",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
