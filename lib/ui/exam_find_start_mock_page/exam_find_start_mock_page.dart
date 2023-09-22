// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_find_start_mock_page/pages/question_view_page/question_view_page.dart';
import 'package:citycloud_school/widegts/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../style/const.dart';
import 'controller/find_exam_start_controller.dart';
import 'widgets/grade_tile.dart';

class ExamFindStartMockPage extends StatefulWidget {
  const ExamFindStartMockPage({super.key, required this.examId});
  final String examId;

  @override
  State<ExamFindStartMockPage> createState() => _ExamFindStartMockPageState();
}

class _ExamFindStartMockPageState extends State<ExamFindStartMockPage> {
  late FindExamStartController examStartController;
  @override
  void initState() {
    examStartController = FindExamStartController(examId: widget.examId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: GetBuilder(
          init: examStartController,
          builder: (controller) {
            if (controller.state == ApiState.success) {
              // print(controller.allExams);
              return AppBar(
                backgroundColor: AppColor.mainColor,
                foregroundColor: AppColor.white,
                titleTextStyle: AppTextStyle.appBarText.copyWith(color: AppColor.white),
                // title: Text("Mathematics - Edition 1"),
                title: Text("${controller.allExams!.examName}"),
                elevation: 1,
                shadowColor: AppColor.white,
                centerTitle: true,
              );
            } else {
              return 0.height;
            }
          },
        ),
      ),

      //
      body: GetBuilder(
        init: examStartController,
        builder: (controller) {
          if (controller.state == ApiState.loading) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColor.white,
            ));
          }
          if (controller.state == ApiState.error) {
            return ErrorPage(
              error: controller.error.toString(),
              onError: () {
                controller.initLoad();
              },
            );
          }

          // success
          return RefreshIndicator(
            onRefresh: () async {
              await controller.reload();
            },
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                GradeTile(
                  title: "Multichoice",
                  time: Duration(minutes: int.parse(controller.allExams?.durationMultichoice ?? "0")),
                  questions: controller.allExams?.multichoiceQuestions?.length ?? 0,
                  grade: controller.allExams?.latestScore?.grade,
                  onStartClick: () {
                    final questionViewPage = MaterialPageRoute(
                      builder: (_) => QuestionViewPage(
                        title: controller.allExams!.examCourseName.toString(),
                        questions: controller.allExams!.multichoiceQuestions!,
                      ),
                    );
                    rootNavigator.currentState!.push(questionViewPage);
                  },
                ),
                18.height,
                GradeTile(
                  title: "Theory",
                  // time: "45 minutes",
                  time: Duration(minutes: int.parse(controller.allExams?.durationTheory ?? "0")),
                  questions: controller.allExams?.theoryQuestions?.length ?? 0,
                  grade: controller.allExams?.latestScore?.grade,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
