// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../style/const.dart';
import 'widgets/grade_tile.dart';

class ExamFindStartMockPage extends StatefulWidget {
  const ExamFindStartMockPage({super.key, required this.examId});
  final String examId;

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
