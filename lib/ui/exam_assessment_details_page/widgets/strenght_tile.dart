// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../style/const.dart';

class StrengthsTile extends StatelessWidget {
  const StrengthsTile({
    super.key,
    required this.text,
    required this.score,
    this.scoreColor = Colors.black,
    this.width = 103,
  });
  final double width;
  final String text;
  final int score;
  final Color? scoreColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 56,
      decoration: BoxDecoration(
        color: AppColor.scaffoldBg,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppTextStyle.text12W400,
          ),
          8.height,
          Text(
            "$score%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: scoreColor,
            ),
          ),
        ],
      ),
    );
  }
}
