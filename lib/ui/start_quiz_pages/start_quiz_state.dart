import 'package:citycloud_school/ui/start_quiz_pages/controller/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'start_quiz_view.dart';

abstract class StartQuizState extends State<StartQuizView> {
  late QuizController quizController;

  @override
  void initState() {
    Get.lazyPut(() => QuizController());
    quizController = Get.find<QuizController>();
    super.initState();
  }
}
