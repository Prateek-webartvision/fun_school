// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../repo/quiz_repo/quiz_repo.dart';
import '../../../style/color.dart';
import '../../../widgets/k_btn.dart';
import '../../start_quiz_pages/model/quiz_model.dart';

class GifResultPage extends StatefulWidget {
  const GifResultPage({
    super.key,
    required this.data,
    required this.isFromVideo,
  });
  final Map<String, dynamic> data;
  final bool isFromVideo;
  // final String

  @override
  State<GifResultPage> createState() => _GifResultPageState();
}

class _GifResultPageState extends State<GifResultPage> {
  late ({int correct, int grade, int wrong}) ans;
  @override
  void initState() {
    String type = widget.data['type'];
    List<QuizModel> data = widget.data['data'];
    String courseId = widget.data['courseId'];
    int subjectId = widget.data['subjectId'];

    ans = getQuizAns(data);
    _setQuizScore(
      title: data.first.title.toString(),
      drage: ans.grade.toString(),
      type: type,
      courseId: courseId,
      subjectId: subjectId.toString(),
    );

    super.initState();
  }

  _setQuizScore(
      {required String title,
      required String drage,
      required String type,
      required String courseId,
      required String subjectId}) async {
    QuizRepository.addQuizScore(
      type: type,
      courseID: courseId,
      title: title,
      subjectid: subjectId,
      score: drage,
    );
  }

  // geting correct or worng ans for quiz
  ({int correct, int wrong, int grade}) getQuizAns(List<QuizModel> data) {
    int cAns = 0;
    int wAns = 0;

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

    int grade = ((cAns / data.length) * 100).round();
    return (correct: cAns, wrong: wAns, grade: grade);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.scaffoldBg,
          title: Text("Result",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          leading: Text(""),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(),
              Text(
                (ans.grade >= 100) ? "Mission Completed" : "Mission Fail",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.mainColor,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (ans.grade >= 100)
                        //success
                        ? Flexible(
                            child: Image.network(
                                "http://app.citycloudschool.co.ke/default/x/upload/success_quiz.gif"),
                            // child: KGifImage(
                            //     url:
                            //         "http://app.citycloudschool.co.ke/default/x/upload/success_quiz.gif"),
                          )
                        : Flexible(
                            child: Image.network(
                                "http://app.citycloudschool.co.ke/default/x/upload/fail_quiz.gif"),
                            // child: KGifImage(
                            //     url:
                            //         "http://app.citycloudschool.co.ke/default/x/upload/fail_quiz.gif"),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          child: KBtn(
            onClick: () {
              if (widget.isFromVideo) {
                rootNavigator.currentState!.pop();
                rootNavigator.currentState!.pop();
                if (ans.grade > 100) {
                  rootNavigator.currentState!.pop();
                }
              } else {
                rootNavigator.currentState!.pop();
                rootNavigator.currentState!.pop();
              }
            },
            text: (ans.grade >= 100)
                ? "Unlock new Content"
                : "better luck next time",
            height: 44,
          ),
        ),
      ),
    );
  }
}
