import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/mock_quiz_controller.dart';
import 'start_quiz_view.dart';

abstract class StartQuizState extends State<StartQuizView> {
  late MockQuizController mockQuizController;

  @override
  void initState() {
    mockQuizController = MockQuizController(title: widget.title, courseID: widget.subjectId);

    Get.lazyPut(() => mockQuizController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
