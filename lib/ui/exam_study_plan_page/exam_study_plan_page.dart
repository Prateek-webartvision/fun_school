// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_preparation_page/controller/exam_study_plan_controller.dart';
import 'package:citycloud_school/ui/exam_study_plan_details_page/exam_study_plan_details_page.dart';
import 'package:citycloud_school/widegts/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:kd_utils/methods/timestemp.dart';

import '../../uitls/app_utils.dart';
import '../../widegts/k_btn.dart';
import '../exam_preparation_page/widgets/create_exam_sheet.dart';
import 'widgets/exam_plan_tile.dart';

class ExamStudyPlan extends StatefulWidget {
  const ExamStudyPlan({super.key, required this.controller});
  final ExamStudyPlanController controller;

  @override
  State<ExamStudyPlan> createState() => _ExamStudyPlanState();
}

class _ExamStudyPlanState extends State<ExamStudyPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   titleTextStyle: AppTextStyle.appBarText,
      //   title: const Text("Study Plan"),
      //   centerTitle: true,
      //   actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))],
      // ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // "Certificate Exams",
                "Exam Study Plan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                // "Dive deep into past questions or explore sample exams.",
                "Craft a tailored study plan, track your progress, and set reminders to ensure you're prepared.",
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

          GetBuilder(
            init: widget.controller,
            builder: (controller) {
              if (controller.state == ApiState.loading) {
                return Column(
                  children: [
                    10.height,
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              }
              if (controller.state == ApiState.error) {
                return ErrorPage(error: controller.error.toString(), onError: () => controller.initLoad());
              }

              //success
              return ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: controller.studyPlans!.length,
                itemBuilder: (context, index) {
                  final plan = controller.studyPlans![index];
                  return ExamStudyPlanTile(
                    // title: "JAMB 2023",
                    title: plan.examName.toString(),
                    date: getDateTimeFromTimeStamp(timeStamp: plan.dateOfExam),
                    progress: plan.progressPercentage!.toInt(),
                    examHour: int.parse(plan.studyHours ?? "0"),
                    onClick: () {
                      final page = MaterialPageRoute(builder: (context) => ExamStudyPlanDetailsPage(studyPlan: plan));
                      rootNavigator.currentState!.push(page);
                    },
                  );
                },
                separatorBuilder: (context, index) => 12.height,
              );
            },
          )
        ],
      ),
    );
  }
}
