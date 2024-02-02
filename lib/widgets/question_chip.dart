// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../style/color.dart';

class QuestionChip extends StatelessWidget {
  const QuestionChip({
    super.key,
    required this.totalQuestions,
    required this.currentQuestion,
  });

  final int totalQuestions;
  final int currentQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 24,
      decoration: BoxDecoration(
        color: AppColor.scaffoldBg,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        "Question $currentQuestion/$totalQuestions",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
