// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/exams/exams_models/all_exam_model.dart';
import '../../../router/app_router.dart';
import '../../exam_find_mock_page/exam_find_mock_page.dart';
import '../../exam_preparation_page/controller/find_exam_controller.dart';
import '../widgets/exam_subject_tile.dart';

class PastQuestionsTab extends StatelessWidget {
  const PastQuestionsTab({
    super.key,
    required this.allExams,
    required this.controller,
  });
  final List<List<AllExamModel>> allExams;
  final FindExamController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // message
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Past Questions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Real past questions by the examination council",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        12.height,
        //body

        if (allExams.isEmpty)
          Center(child: Text("No Exams"))
        else
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: allExams.length,
            itemBuilder: (context, index) {
              final exam = allExams[index];
              return ExamSubjectTile(
                // title: "English Literature",
                title: exam.first.examCourseName ?? "N/A",
                editions: exam.length,

                onClick: () {
                  MaterialPageRoute examFindEditionPage = MaterialPageRoute(
                    builder: (_) =>
                        ExamFindEditions(exam: exam, controller: controller),
                  );
                  rootNavigator.currentState!.push(examFindEditionPage);
                },
              );
            },
            separatorBuilder: (context, index) => 20.height,
          ),
      ],
    );
  }
}
