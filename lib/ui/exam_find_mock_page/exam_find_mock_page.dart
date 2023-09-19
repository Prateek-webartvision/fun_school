// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../models/exams/exams_models/all_exam_model.dart';
import '../../router/app_router.dart';
import '../../style/const.dart';
import '../exam_find_start_mock_page/exam_find_start_mock_page.dart';
import '../exam_preparation_page/controller/find_exam_crontroller.dart';
import 'widgets/subject_tile.dart';

class ExamFindEditions extends StatefulWidget {
  const ExamFindEditions({super.key, required this.exam, required this.crontroller});
  final List<AllExamModel> exam;
  final FindExamCrontroller crontroller;

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
                "${widget.exam.length} Edtition",
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
                  // title: "Mathematics Edition 1",
                  title: item.examName!,
                  questions: 20,
                  onClick: () {
                    // rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => StartExamPage()));
                    rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => ExamFindStartMockPage()));
                  });
            },
            separatorBuilder: (context, index) => 8.height,
          )
          // MockSubjectTile(
          //     title: "Mathematics Edition 1",
          //     questions: 20,
          //     onClick: () {
          //       // rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => StartExamPage()));
          //       rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => ExamFindStartMockPage()));
          //     }),
          // 8.height,
          // MockSubjectTile(title: "Mathematics Edition 2", questions: 20),
          // 8.height,
          // MockSubjectTile(title: "Mathematics Edition 3", questions: 20),
        ],
      ),
    );
  }
}
