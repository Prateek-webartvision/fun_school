// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../../router/app_router.dart';
import '../../../style/color.dart';
import '../controller/mock_quiz_controller.dart';
import 'quiz_tabs/mock_quiz_tab_page.dart';

class QuizQustionQnswerPage extends StatelessWidget {
  const QuizQustionQnswerPage({
    super.key,
    required this.extraController,
    required this.subjectId,
    required this.courseId,
  });
  final MockQuizController extraController;
  final int subjectId;
  final String courseId;

  popBack2Times() {
    rootNavigator.currentState!.pop();
    rootNavigator.currentState!.pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        popBack2Times();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.scaffoldBg,
          title: Text("Mock Test", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          leading: GestureDetector(
            onTap: popBack2Times,
            child: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: MockQuizTabPage(
          mockQuizController: extraController,
          subjectId: subjectId.toString(),
          courseId: courseId,
        ),
      ),
    );
  }
}
