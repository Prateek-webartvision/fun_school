// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widgets/point_chip.dart';
import '../../../widgets/question_chip.dart';

class HeadQuestion extends StatelessWidget {
  const HeadQuestion({
    super.key,
    required this.totalQ,
    required this.currentQ,
    required this.question,
    this.points,
  });
  final int totalQ;
  final int currentQ;
  final String question;
  final int? points;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        // borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: (currentQ / totalQ),
            minHeight: 6,
            borderRadius: BorderRadius.circular(6),
          ),
          14.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuestionChip(
                totalQuestions: totalQ,
                currentQuestion: currentQ,
              ),
              PointChip(point: points)
            ],
          ),
          8.height,
          Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
