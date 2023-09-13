// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../style/const.dart';
import '../exam_find_start_mock_page/exam_find_start_mock_page.dart';
import 'widgets/subject_tile.dart';

class ExamFindMock extends StatefulWidget {
  const ExamFindMock({super.key});

  @override
  State<ExamFindMock> createState() => _ExamFindMockState();
}

class _ExamFindMockState extends State<ExamFindMock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: const Text("Find Exams"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // message
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mathematics",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              Text(
                "30 Edtition",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          12.height,
          MockSubjectTile(
              title: "Mathematics Edition 1",
              questions: 20,
              onClick: () {
                // rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => StartExamPage()));
                rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => ExamFindStartMockPage()));
              }),
          8.height,
          MockSubjectTile(title: "Mathematics Edition 2", questions: 20),
          8.height,
          MockSubjectTile(title: "Mathematics Edition 3", questions: 20),
        ],
      ),
    );
  }
}
