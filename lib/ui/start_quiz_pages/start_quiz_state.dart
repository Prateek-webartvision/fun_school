import 'package:citycloud_school/ui/start_quiz_pages/controller/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/mock_quiz_controller.dart';
import 'start_quiz_view.dart';

abstract class StartQuizState extends State<StartQuizView> {
  late MockQuizController mockQuizController;
  late QuizController quizController;

  @override
  void initState() {
    quizController = QuizController(title: widget.title, subjectId: widget.subjectId);
    mockQuizController = MockQuizController(title: widget.title, courseID: widget.subjectId);

    Get.lazyPut(() => mockQuizController);
    Get.lazyPut(() => quizController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
