// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_preparation_page/controller/exam_study_plan_controller.dart';
import 'package:citycloud_school/ui/exam_study_plan_details_page/exam_study_plan_details_page.dart';
import 'package:citycloud_school/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:kd_utils/methods/timestemp.dart';

import '../../repo/exams/exam_study_plan_repo.dart';
import '../../utils/app_utils.dart';
import '../../widgets/k_btn.dart';
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
              showModalBottomSheet(
                context: rootNavigator.currentContext!,
                builder: (context) {
                  var sheetBottomSpace = MediaQuery.of(context).viewInsets;

                  // return SizedBox(height: 100, child: KTextField());
                  return Padding(
                    padding: sheetBottomSpace,
                    child: CreateExamSheet(
                      courses: widget.controller.courseslist,
                      onCreate: (name, examDate, selectedCourses, studyHour,
                          periods, reminderSteeing, reminderTime) {
                        AppUtils.showLoadingOverlay(() async {
                          await ExamStudyPlanRepository.addStudyPlan(
                            examName: name,
                            examDate: examDate,
                            courses: selectedCourses,
                            studyHour: studyHour,
                            periods: periods,
                            reminder: reminderSteeing,
                            reminderTime: reminderTime,
                          ).then((value) {
                            AppUtils.showSnack(value);
                            widget.controller.reload();
                          }).onError((error, stackTrace) {
                            AppUtils.showSnack(error.toString());
                          });
                        });
                      },
                      // onCreate: () {
                      //   // print("object");
                      // },
                    ),
                  );
                },
                clipBehavior: Clip.hardEdge,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              );
              Future.delayed(
                Duration(seconds: 1),
                () {},
              );
              // AppUtils.showModelSheet(
              //   child: Padding(
              //     padding: MediaQuery.of(rootNavigator.currentState!.context).viewInsets,
              //     child: SizedBox(height: 60, child: KTextField()),
              //     // child: CreateExamSheet(
              //     //   courses: widget.controller.courseslist,
              //     //   onCreate: () {
              //     //     // print("object");
              //     //     // ExamStudyPlanRepository.addStudyPlan();
              //     //   },
              //     // ),
              //   ),
              //   bgColor: Colors.white,
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
              //   isScrolled: true,
              // );
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
                return ErrorPage(
                    error: controller.error.toString(),
                    onError: () => controller.initLoad());
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
                    examHour: int.parse(plan.progressHours ?? "0"),
                    onClick: () {
                      final page = MaterialPageRoute(
                          builder: (context) =>
                              ExamStudyPlanDetailsPage(studyPlan: plan));
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
