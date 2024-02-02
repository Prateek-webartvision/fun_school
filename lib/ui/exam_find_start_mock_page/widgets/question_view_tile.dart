// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widgets/point_chip.dart';
import '../../../widgets/question_chip.dart';

class QuestionViewTile extends StatelessWidget {
  const QuestionViewTile({
    super.key,
    required this.totalQ,
    required this.currentQ,
    required this.points,
    required this.question,
    this.onClick,
  });
  final int totalQ;
  final int currentQ;
  final int points;
  final String question;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuestionChip(totalQuestions: totalQ, currentQuestion: currentQ),
                PointChip(point: points),
              ],
            ),
            8.height,
            //
            Text(
              question,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
