// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../repo/quiz_repo/quiz_repo.dart';
import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';
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

  _setQuizScore({required String title, required String drage, required String type, required String courseId, required String subjectId}) async {
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
            title: Text("Result", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            leading: Text(""),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(),
                Text(
                  (ans.grade >= 75) ? "Mission Completed" : "Mission Fail",
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
                      (ans.grade >= 75)
                          ? Flexible(child: Image(image: NetworkImage("https://rochakjankari.in/wp-content/uploads/2021/02/giphyuu.gif")))
                          : Flexible(
                              child: Image(
                                  image: NetworkImage(
                                      "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/44b6695e-9ae7-4039-bd65-cede627e03dc/d65l57k-5ead046b-078f-4938-ad13-6608474b0547.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzQ0YjY2OTVlLTlhZTctNDAzOS1iZDY1LWNlZGU2MjdlMDNkY1wvZDY1bDU3ay01ZWFkMDQ2Yi0wNzhmLTQ5MzgtYWQxMy02NjA4NDc0YjA1NDcuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.TyrGh1bDE3nFq3sLgGpHosphVvn7pJjR_CPbZVA8Tbg")),
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
                  if (ans.grade > 75) {
                    rootNavigator.currentState!.pop();
                  }
                } else {
                  rootNavigator.currentState!.pop();
                  rootNavigator.currentState!.pop();
                }
              },
              text: (ans.grade >= 75) ? "Unlock new Content" : "better luck next time",
              height: 44,
            ),
          )),
    );
  }
}
