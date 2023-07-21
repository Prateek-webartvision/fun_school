// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../router/app_router.dart';
import '../../../router/pages.dart';
import '../../interactive_quiz_page/controller/quiz_controller.dart';

class KQuizLoadingPage extends StatefulWidget {
  const KQuizLoadingPage({
    super.key,
    required this.title,
    required this.subjectId,
    required this.courseId,
    required this.index,
    this.isFromVideo = false,
  });
  final String title;
  final int subjectId;
  final String courseId;
  final int index;
  final bool isFromVideo;

  @override
  State<KQuizLoadingPage> createState() => _KQuizLoadingPageState();
}

class _KQuizLoadingPageState extends State<KQuizLoadingPage> {
  late QuizController quizController;
  bool isShow = false;

  @override
  void initState() {
    quizController = QuizController(
      misstionIdex: widget.index,
      title: widget.title,
      subjectId: widget.subjectId,
    );
    super.initState();
  }

  @override
  void dispose() {
    if (quizController.apiState != ApiState.loading) {
      quizController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: quizController,
        builder: (controller) {
          if (controller.apiState == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.apiState == ApiState.error) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              rootNavigator.currentState!.pop(controller.error);
              // AppUtils.showSnack(controller.error);
            });
            return Text("");
          } else if (controller.quizs != null && controller.quizs!.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              rootNavigator.currentState!.pop("No Mission");
              // print("object");
              // await Future.delayed(Duration(seconds: 1));
            });

            return Text("");
          } else {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              // nev to quiz
              final data = {"controller": quizController, "courseId": widget.courseId, "subjectId": widget.subjectId};
              // print(data);
              if (isShow != true) {
                await appRoutes.pushNamed(PagesName.quizQustionAnswerPage, extra: data);
              }
              setState(() {
                isShow = true;
              });
            });
            return Text("");
          }
        },
      ),
    );
  }
}
