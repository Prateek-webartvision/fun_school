// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:citycloud_school/ui/start_quiz_pages/model/mock_quiz_model.dart';
import 'package:citycloud_school/ui/start_quiz_pages/model/quiz_model.dart';
import 'package:citycloud_school/ui/start_quiz_pages/quiz_result_page/quiz_result_state.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../style/color.dart';

class QuizResultPage extends StatefulWidget {
  const QuizResultPage({
    super.key,
    required this.quizWithAns,
    required this.type,
    required this.subjectId,
    required this.courseId,
  });
  final dynamic quizWithAns;
  final String type;
  final String subjectId;
  final String courseId;

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends QuizResultState {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text("Result", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ResultHead(
            corretAns: correctAns,
            worngAns: worngAns,
            grade: grade,
            onShare: (widget) async {
              final ss = await screenshotController.captureFromWidget(widget);

              final tempDir = await getTemporaryDirectory();
              File file = await File("${tempDir.path}/result.jpg").create();

              file.writeAsBytesSync(ss);

              AppUtils.showloadingOverlay(() async {
                final res = await Share.shareXFiles(
                  [XFile(file.path)],
                  text: "Result",
                  subject: 'Result',
                );
                print(res);
              });
            },
          ),
          //     //     // ans tils
          Expanded(
            child: (widget.quizWithAns is List<MockQuizModel>)
                ? ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: widget.quizWithAns.length,
                    itemBuilder: (context, index) {
                      final data = widget.quizWithAns[index];
                      return _AnsTile(
                        currentQuestions: index,
                        totalQuestions: widget.quizWithAns.length,
                        quations: data.question!,
                        isCorrect: (data.correctAnswer == data.seletedAmswer),
                      );
                    },
                    separatorBuilder: (context, index) => 10.height,
                  )
                // Quiz
                : ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: widget.quizWithAns.length,
                    itemBuilder: (context, index) {
                      QuizModel data = widget.quizWithAns[index];
                      // chacking correct ans
                      var res = data.quizData!.where((element) => element.correctAnswer == element.selectedAns);

                      return _AnsTile(
                        currentQuestions: index,
                        totalQuestions: widget.quizWithAns.length,
                        quations: data.questionTitle!,
                        // isCorrect: false,
                        isCorrect: (data.quizData!.length == res.length),
                      );
                    },
                    separatorBuilder: (context, index) => 10.height,
                  ),
          ),
        ],
      ),
    );
  }
}

class ResultHead extends StatelessWidget {
  const ResultHead({
    super.key,
    required this.corretAns,
    required this.worngAns,
    required this.grade,
    required this.onShare,
  });
  final int corretAns;
  final int worngAns;
  final int grade;
  final Function(Widget widget) onShare;

  String get passMessage => "Congratulations! You passed!";
  String get failMessage => "Sorry! You failed! You can retake the quiz";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        // borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pass message
          head(),
          // share btn
          GestureDetector(
            onTap: () => onShare(
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Fun School",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    8.height,
                    head(),
                  ],
                ),
              ),
            ),
            child: Container(
              height: 44,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(4),
              ),
              // padding: EdgeInsets.s,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share_outlined),
                  6.45.width,
                  Text(
                    "Share Result",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget head() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColor.mainColor,
                size: 32,
              ),
              8.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (grade >= 75) ? passMessage : failMessage,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
                      // overflow: TextOverflow.ellipsis,
                    ),
                    4.height,
                    RichText(
                      text: TextSpan(
                        text: "TO PASS",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                        children: [
                          TextSpan(text: " "),
                          TextSpan(
                            text: "75% or higher",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.height,
          // grade
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Grade",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    // "99%",
                    "$grade%",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColor.pinkColor,
                    ),
                  ),
                ],
              ),
              17.width,
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.green,
                          size: 18,
                        ),
                        4.width,
                        Text(
                          "Correct",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    6.height,
                    Row(
                      children: [
                        Transform.rotate(
                          angle: 0.75,
                          child: Icon(
                            Icons.add_circle_outline_rounded,
                            color: Color(0xffFF0000),
                            size: 18,
                          ),
                        ),
                        4.width,
                        Text(
                          "Incorrect",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  // number off correct answers
                  Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      color: AppColor.scaffoldBg,
                      border: Border.all(color: AppColor.softBorderColor),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      // "6",
                      corretAns.toString(),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff008000)),
                    ),
                  ),
                  4.height,
                  // no. of worng ans
                  Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      color: AppColor.scaffoldBg,
                      border: Border.all(color: AppColor.softBorderColor),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      worngAns.toString(),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xffFF0000)),
                    ),
                  ),
                ],
              )
            ],
          ),
          12.height,
        ],
      );
}

//
class _AnsTile extends StatelessWidget {
  const _AnsTile({
    super.key,
    required this.isCorrect,
    required this.quations,
    required this.totalQuestions,
    required this.currentQuestions,
  });
  final bool isCorrect;
  final String quations;
  final int totalQuestions;
  final int currentQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 24,
                decoration: BoxDecoration(
                  color: AppColor.scaffoldBg,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  "Question ${currentQuestions + 1}/${totalQuestions}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.scaffoldBg,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColor.textFeildBorderColor),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  "1 point",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          8.height,
          Text(
            // "Of the following, which best describes a variable?",
            quations,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.height,
          (isCorrect)
              ? Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.green,
                      size: 18,
                    ),
                    4.width,
                    Text(
                      "Correct",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Transform.rotate(
                      angle: 0.75,
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        color: Color(0xffFF0000),
                        size: 18,
                      ),
                    ),
                    4.width,
                    Text(
                      "Incorrect",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
