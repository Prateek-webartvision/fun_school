// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../style/const.dart';

class ExamFindStartMockPage extends StatefulWidget {
  const ExamFindStartMockPage({super.key});

  @override
  State<ExamFindStartMockPage> createState() => _ExamFindStartMockPageState();
}

class _ExamFindStartMockPageState extends State<ExamFindStartMockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        foregroundColor: AppColor.white,
        titleTextStyle: AppTextStyle.appBarText.copyWith(color: AppColor.white),
        title: Text("Mathematics - Edition 1"),
        elevation: 1,
        shadowColor: AppColor.white,
        centerTitle: true,
      ),
      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          GradeTile(
            title: "Multichoice",
            time: "45 minutes",
            questions: 20,
            onStartClick: () {
              print("object");
            },
          ),
          18.height,
          GradeTile(
            title: "Theory",
            time: "45 minutes",
            questions: 3,
          )
        ],
      ),
    );
  }
}

class GradeTile extends StatelessWidget {
  const GradeTile({
    super.key,
    required this.title,
    required this.time,
    required this.questions,
    this.grade,
    this.onStartClick,
  });
  final String title;
  final String time;
  final int questions;
  final String? grade;
  final Function()? onStartClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
          Text(
            "$time • $questions Questions",
            style: TextStyle(
              fontSize: 16,
              color: AppColor.white,
            ),
          ),
          12.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Receive grade",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.white,
                ),
              ),
              Text(
                "TO PASS 75% or higher",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grade",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.white,
                ),
              ),
              Text(
                grade ?? "---",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
          12.height,
          GestureDetector(
            onTap: onStartClick,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColor.textFeildBorderColor.withOpacity(0.4),
                  )),
              alignment: Alignment.center,
              child: Text(
                "Start",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColor.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
