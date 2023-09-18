// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_find_mock_page/exam_find_mock_page.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../widgets/exam_subject_tile.dart';

class MockExamTab extends StatelessWidget {
  const MockExamTab({
    super.key,
  });

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
            ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                ExamSubjectTile(
                  title: "Mathematics",
                  editions: 30,
                  onClick: () {
                    Navigator.of(rootNavigator.currentContext!).push(
                      MaterialPageRoute(
                        builder: (context) => ExamFindMock(),
                      ),
                    );
                  },
                ),
                8.height,
                ExamSubjectTile(
                  title: "English Literature",
                  editions: 30,
                ),
              ],
            )
          ],
        ),
        12.height,
      ],
    );
  }
}