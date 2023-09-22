// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

class AnswerIndicator extends StatelessWidget {
  const AnswerIndicator({
    super.key,
    required this.isCurrect,
  });
  final bool isCurrect;

  @override
  Widget build(BuildContext context) {
    if (isCurrect) {
      return Row(
        children: [
          Icon(
            Icons.check_circle_outline_outlined,
            // color: Colors.green,
            color: AppColor.green,
            size: 18,
          ),
          4.width,
          Text(
            "Correct",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.green,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Transform.rotate(
            angle: 0.75,
            child: Icon(
              Icons.add_circle_outline_rounded,
              // color: Color(0xffFF0000),
              color: AppColor.red,
              size: 18,
            ),
          ),
          4.width,
          Text(
            "Incorrect",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.red,
            ),
          ),
        ],
      );
    }
  }
}
