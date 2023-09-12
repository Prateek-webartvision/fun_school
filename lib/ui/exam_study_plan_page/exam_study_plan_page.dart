// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_study_plan_details_page/exam_study_plan_details_page.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/const.dart';
import '../../uitls/app_utils.dart';
import '../../widegts/k_btn.dart';
import '../exam_preparation_page/widgets/create_exam_sheet.dart';
import 'widgets/exam_plan_tile.dart';

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
          CreateStudyPlanBtn(
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
          12.height,
          // plans

          ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              ExamStudyPlanTile(
                title: "JAMB 2023",
                date: DateTime(2023, 9, 10),
                progress: 40,
                onClick: () {
                  rootNavigator.currentState!.push(MaterialPageRoute(builder: (context) => ExamStudyPlanDetailsPage()));
                },
              ),
              12.height,
              ExamStudyPlanTile(
                title: "WAEC Mock 2023",
                date: DateTime(2023, 10, 15),
                progress: 25,
              ),
              12.height,
              ExamStudyPlanTile(
                title: "SSCE Practice",
                date: DateTime(2023, 11, 20),
                progress: 55,
              ),
            ],
          )
        ],
      ),
    );
  }
}
