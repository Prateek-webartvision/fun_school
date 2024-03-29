// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/ui/exam_assessment_page/exam_assessment_page.dart';
import 'package:fun_school/ui/exam_study_plan_page/exam_study_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import 'exam_preparation_page_state.dart';
import 'tab_pages/find_an_exam_tab.dart';

class ExamPreparationPage extends StatefulWidget {
  const ExamPreparationPage({super.key});

  @override
  State<ExamPreparationPage> createState() => _ExamPreparationPageState();
}

class _ExamPreparationPageState extends ExamPreparationPageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.pinkColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(),
                Text(
                  "Examination Hub",
                  style: GoogleFonts.inter(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                4.height,
                Text(
                  "Prepare, Practice, and Perfect your scores.",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.darkTextColor,
                  ),
                ),
                12.height,
              ],
            ),
          ),
          Divider(height: 0),
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Find Exam"),
              Tab(text: "Study Plan"),
              Tab(text: "Assessments"),
            ],
          ),
          16.height,
          // tabs
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                FindAnExamTab(controller: findExamController),
                ExamStudyPlan(controller: examStudyPlanController),
                ExamMyAssessmentsPage()
              ],
            ),
          )
        ],
      ),
    );
  }
}
