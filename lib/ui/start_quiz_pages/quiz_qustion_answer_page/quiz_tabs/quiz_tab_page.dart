import 'package:flutter/material.dart';

import '../../controller/quiz_controller.dart';

class QuizTabPage extends StatelessWidget {
  const QuizTabPage({
    super.key,
    required this.quizController,
  });
  final QuizController quizController;

  @override
  Widget build(BuildContext context) {
    return Text("data ${quizController.quizs!.length}");
  }
}
