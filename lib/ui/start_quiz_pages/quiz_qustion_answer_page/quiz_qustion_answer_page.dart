// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../../router/app_router.dart';
import '../../../style/color.dart';
import '../controller/mock_quiz_controller.dart';
import '../widgets/no_quiz_found.dart';
import 'quiz_tabs/mock_quiz_tab_page.dart';
import 'quiz_tabs/quiz_tab_page.dart';

class QuizQustionQnswerPage extends StatelessWidget {
  const QuizQustionQnswerPage({
    super.key,
    this.extraController,
    required this.courseID,
  });
  final dynamic extraController;
  final int courseID;

  popBack2Times() {
    appRoutes.pop();
    appRoutes.pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        popBack2Times();
        return false;
      },
      child: (extraController != null)
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: AppColor.scaffoldBg,
                title: Text((extraController is MockQuizController) ? "Mock Test" : "Quiz", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                leading: GestureDetector(
                  onTap: popBack2Times,
                  child: Icon(Icons.arrow_back),
                ),
                centerTitle: true,
              ),
              body: (extraController is MockQuizController)
                  ? MockQuizTabPage(
                      mockQuizController: extraController,
                      courseID: courseID.toString(),
                    )
                  : QuizTabPage(
                      //ToDO
                      quizController: extraController,
                      courseID: courseID.toString(),
                    ),
            )
          // No quiz controller found
          : NoQuizFoundWidget(),
    );
  }
}
