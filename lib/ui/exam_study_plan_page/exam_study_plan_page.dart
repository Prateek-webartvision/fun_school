// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/const.dart';
import '../../uitls/app_utils.dart';
import '../../widegts/k_btn.dart';
import '../exam_preparation_page/widgets/create_exam_sheet.dart';

class ExamStudyPlan extends StatefulWidget {
  const ExamStudyPlan({super.key});

  @override
  State<ExamStudyPlan> createState() => _ExamStudyPlanState();
}

class _ExamStudyPlanState extends State<ExamStudyPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: const Text("Study Plan"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Certificate Exams",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Dive deep into past questions or explore sample exams.",
                style: TextStyle(fontSize: 14),
              ),
              12.height,
            ],
          ),
          CreatePlanBtn(
            onTap: () {
              // Create new study plan sheet
              AppUtils.showModelSheet(
                child: CreateExamSheet(),
                bgColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
                isScrolled: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
