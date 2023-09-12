// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/const.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../style/color.dart';

class AnswersTile extends StatelessWidget {
  const AnswersTile({
    super.key,
    this.isCorrect = false,
    this.totalQuestions = 0,
    this.currentQuestion = 0,
    this.points = 0,
    required this.question,
    required this.otherText,
  }) : assert(
          totalQuestions >= currentQuestion,
        );

  final bool isCorrect;
  final int totalQuestions;
  final int currentQuestion;
  final int points;
  final String question;
  final String otherText;

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
          _getQuestionIndictor(current: currentQuestion, total: totalQuestions),
          8.height,
          Text(
            question,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          8.height,
          Text(
            otherText,
            style: AppTextStyle.text12W400,
          ),
          8.height,
          _getCurrect(isCorrect),
        ],
      ),
    );
  }
}

Widget _getQuestionIndictor({required int current, required int total}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.scaffoldBg,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: Colors.black),
    ),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: Text(
      "Question $current/$total",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget _getCurrect(bool isCorrect) {
  if (isCorrect) {
    return Row(
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
    );
  } else {
    return Row(
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
    );
  }
}
