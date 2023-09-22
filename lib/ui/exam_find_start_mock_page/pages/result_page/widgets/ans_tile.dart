// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../../style/color.dart';

class AnsTile extends StatelessWidget {
  const AnsTile({
    super.key,
    required this.isCorrect,
    required this.question,
    required this.totalQ,
    required this.currentQ,
    required this.points,
  });
  final int totalQ;
  final int currentQ;
  final String question;
  final int points;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "Question $currentQ/$totalQ",
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
                  "$points point",
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
            // "Of the following, which best describes a variable?",
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.height,
          (isCorrect)
              ? Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.green,
                      size: 18,
                    ),
                    4.width,
                    Text(
                      "Correct",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Transform.rotate(
                      angle: 0.75,
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        color: Color(0xffFF0000),
                        size: 18,
                      ),
                    ),
                    4.width,
                    Text(
                      "Incorrect",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
