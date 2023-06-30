import 'package:flutter/material.dart';

import 'quiz_result_page.dart';

abstract class QuizResultState extends State<QuizResultPage> {
  late int correctAns;
  late int worngAns;
  late int grade;

  @override
  void initState() {
    final ans = getAns();
    correctAns = ans.correct;
    worngAns = ans.wrong;
    grade = ans.grade;
    super.initState();
  }

  // geting correct or worng ans
  ({int correct, int wrong, int grade}) getAns() {
    int cAns = 0;
    int wAns = 0;
    for (var element in widget.quizWithAns) {
      if (element.correctAnswer == element.seletedAmswer) {
        cAns++;
      } else {
        wAns++;
      }
    }
    int grade = ((cAns / widget.quizWithAns.length) * 100).round();

    return (correct: cAns, wrong: wAns, grade: grade);
  }
}
