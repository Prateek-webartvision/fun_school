import 'package:citycloud_school/ui/start_quiz_pages/model/mock_quiz_model.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/quiz_model.dart';
import 'package:flutter/material.dart';

import 'quiz_result_page.dart';

abstract class QuizResultState extends State<QuizResultPage> {
  late int correctAns;
  late int worngAns;
  late int grade;

  @override
  void initState() {
    late final ans;
    if (widget.quizWithAns is List<MockQuizModel>) {
      ans = getMockAns();
    } else {
      ans = getQuizAns();
    }
    correctAns = ans.correct;
    worngAns = ans.wrong;
    grade = ans.grade;
    super.initState();
  }

  // geting correct or worng ans for mock quiz
  ({int correct, int wrong, int grade}) getMockAns() {
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

  // geting correct or worng ans for quiz
  ({int correct, int wrong, int grade}) getQuizAns() {
    int cAns = 0;
    int wAns = 0;
    final data = widget.quizWithAns as List<QuizModel>;
    for (var element in data) {
      var res = element.quizData!.where(
        (e) {
          // print("${e.selectedAns} == ${e.correctAnswer}");
          if (e.correctAnswer == e.selectedAns) {
            return true;
          } else {
            return false;
          }
        },
      );

      if (res.length == element.quizData!.length) {
        cAns++;
      } else {
        wAns++;
      }
    }
    //
    int grade = ((cAns / widget.quizWithAns.length) * 100).round();
    return (correct: cAns, wrong: wAns, grade: grade);
  }
}
