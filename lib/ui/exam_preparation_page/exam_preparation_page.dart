// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import 'exam_pewparation_page_state.dart';
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
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                4.height,
                Text(
                  "Prepare, Practice, and Perfect your scores.",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.darkTextColor,
                  ),
                ),
                // 12.height,
                // Container(
                //   height: 84,
                //   width: double.maxFinite,
                //   decoration: BoxDecoration(
                //     color: AppColor.white,
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   clipBehavior: Clip.hardEdge,
                //   child: Row(children: [
                //     ExamTabBtns(
                //       svgImageIcon: AppAssets.svg.examSearch,
                //       title: "Find Exams",
                //       onTap: () {
                //         AppUtils.slidePush(page: FindExamPage());
                //       },
                //     ),
                //     ExamTabBtns(
                //       svgImageIcon: AppAssets.svg.examStudy,
                //       title: "Study Plan",
                //       onTap: () {
                //         AppUtils.slidePush(page: ExamStudyPlan());
                //       },
                //     ),
                //     ExamTabBtns(
                //       svgImageIcon: AppAssets.svg.examAssessment,
                //       title: "Assessments",
                //       onTap: () {
                //         // assessment page
                //         AppUtils.slidePush(page: ExamMyAssessmentsPage());
                //       },
                //     ),
                //   ]),
                // ),
                12.height,
              ],
            ),
          ),
          Divider(height: 0),
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: "Find Exam",
              ),
              Tab(
                text: "Study Plan",
              ),
              Tab(
                text: "Assessments",
              ),
            ],
          ),
          16.height,
          // tabs
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                FindAnExamTab(crontroller: findExamCrontroller),
                Text("data"),
                Text("data"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
