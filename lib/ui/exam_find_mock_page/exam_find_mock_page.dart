// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../models/exams/exams_models/all_exam_model.dart';
import '../../router/app_router.dart';
import '../../style/const.dart';
import '../exam_find_start_mock_page/exam_find_start_mock_page.dart';
import '../exam_preparation_page/controller/find_exam_controller.dart';
import 'widgets/subject_tile.dart';

class ExamFindEditions extends StatefulWidget {
  const ExamFindEditions({
    super.key,
    required this.exam,
    required this.controller,
  });
  final List<AllExamModel> exam;
  final FindExamController controller;

  @override
  State<ExamFindEditions> createState() => _ExamFindEditionsState();
}

class _ExamFindEditionsState extends State<ExamFindEditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: const Text("Find Exams"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // message
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // "Mathematics",
                widget.exam.first.examCourseName ?? "N/A",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${widget.exam.length} Edition",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          12.height,
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.exam.length,
            itemBuilder: (context, index) {
              final item = widget.exam[index];
              return MockSubjectTile(
                  title: item.examName!,
                  multiChoiceQuestions: item.multiChoiceQuestionsCount ?? 0,
                  theoryQuestions: item.theoryQuestionsCount ?? 0,
                  onClick: () {
                    // check question before open exam
                    if (item.multiChoiceQuestionsCount! <= 0 &&
                        item.theoryQuestionsCount! <= 0) {
                      AppUtils.showSnack("No Question to show");
                    } else {
                      final examStatPage = MaterialPageRoute(
                        builder: (_) => ExamFindStartMockPage(
                            examId: item.examId.toString()),
                      );
                      rootNavigator.currentState!.push(examStatPage);
                    }
                  });
            },
            separatorBuilder: (context, index) => 8.height,
          )
        ],
      ),
    );
  }
}
