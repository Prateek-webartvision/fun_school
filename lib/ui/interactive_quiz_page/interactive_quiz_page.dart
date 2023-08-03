// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/interactive_quiz_page/quiz_tab_page.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../repo/quiz_repo/quiz_repo.dart';
import '../../style/color.dart';
import 'controller/quiz_controller.dart';
import 'gif_result_page/gif_result_page.dart';

// Not in use

class InteractiveQuizPage extends StatefulWidget {
  const InteractiveQuizPage({
    super.key,
    required this.title,
    required this.subjectId,
    required this.misstionIdex,
    required this.courseId,
    this.isFromVideo = false,
  });
  final String title;
  final int subjectId;
  final int misstionIdex;
  final String courseId;
  final bool isFromVideo;

  @override
  State<InteractiveQuizPage> createState() => _InteractiveQuizPageState();
}

class _InteractiveQuizPageState extends State<InteractiveQuizPage> {
  late QuizController quizController;

  @override
  void initState() {
    quizController = QuizController(
      title: widget.title,
      subjectId: widget.subjectId,
      misstionIdex: widget.misstionIdex,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _pop() {
    rootNavigator.currentState!.pop();
  }

  @override
  Widget build(BuildContext context) {
    // return Text("data");
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
        init: quizController,
        builder: (controller) {
          if (controller.apiState == ApiState.loading) {
            return Material(child: Center(child: CircularProgressIndicator()));
          } else if (controller.apiState == ApiState.error) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _pop();
              AppUtils.showSnack(controller.error.toString());
            });
            return Material();
          } else {
            if (controller.quizs != null && controller.quizs!.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _pop();
                AppUtils.showSnack("No Quiz Found");
              });
              return Material();
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColor.scaffoldBg,
                title: Text("Quiz", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                // leading: GestureDetector(
                //   onTap: _pop,
                //   child: Icon(Icons.arrow_back),
                // ),
                centerTitle: true,
              ),
              // body: Text("${quizController.currentQuizIndex} ${widget.title}"),
              body: QuizTabPage(
                quizController: quizController,
                subjectId: widget.subjectId.toString(),
                courseId: widget.courseId,
                onCencel: () => _pop(),
                onSubmit: () {
                  final data = {
                    "type": QuizType.quiz,
                    "data": controller.quizs,
                    "courseId": widget.courseId,
                    "subjectId": widget.subjectId,
                  };
                  print(data);

                  rootNavigator.currentState!.push(
                    MaterialPageRoute(
                      builder: (context) => GifResultPage(data: data, isFromVideo: widget.isFromVideo),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
