import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/exams/exams_models/theory_question_model.dart';

class TheoryAnswerController extends GetxController {
  late int index;
  final List<TheoryQuestionModel> questions;

  TheoryAnswerController({int initIndex = 0, required this.questions}) {
    index = initIndex;
  }

  submitandAnswerAndNext(TextEditingController answer) async {
    if ((questions.length - 1) > index) {
      index++;
      answer.clear();
      update();
    }
  }
}
