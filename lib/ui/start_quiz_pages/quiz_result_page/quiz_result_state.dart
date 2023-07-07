import 'package:citycloud_school/repo/quiz_repo/quiz_repo.dart';
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
    late final ({int correct, int grade, int wrong}) ans;
    late final String title;
    late final String subjectID;

    if (widget.quizWithAns is List<MockQuizModel>) {
      ans = getMockAns();
      var ss = widget.quizWithAns as List<MockQuizModel>;
      title = ss.first.title!;
      subjectID = ss.first.subjectId!;
    } else {
      ans = getQuizAns();
      var ss = widget.quizWithAns as List<QuizModel>;
      title = ss.first.title!;
      subjectID = ss.first.subjectId!;
    }
    correctAns = ans.correct;
    worngAns = ans.wrong;
    grade = ans.grade;

    _setQuizScore(
      title: title,
      subjectId: subjectID,
      drage: ans.grade.toString(),
    );
    super.initState();
  }

  _setQuizScore({required String title, required String subjectId, required String drage}) async {
    QuizRepository.addQuizScore(
      type: widget.type,
      courseID: widget.courseId,
      title: title,
      subjectid: subjectId,
      score: grade.toString(),
    );
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
