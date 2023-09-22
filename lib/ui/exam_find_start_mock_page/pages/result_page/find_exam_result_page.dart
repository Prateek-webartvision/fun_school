// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/repo/exams/exams_repo.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_find_start_mock_page/pages/answer_review_page/answer_review_page.dart';

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../style/color.dart';
import '../../../../widegts/k_btn.dart';
import '../../controller/question_answer_controller.dart';
import 'widgets/ans_tile.dart';

class FindExamResultPage extends StatefulWidget {
  const FindExamResultPage({super.key, required this.controller});
  final QuestionAnswerController controller;

  @override
  State<FindExamResultPage> createState() => _FindExamResultPageState();
}

class _FindExamResultPageState extends State<FindExamResultPage> {
  late ({int correctAns, int grade, int inCorrectAns}) ans;
  @override
  void initState() {
    ans = widget.controller.getResult();
    final examId = widget.controller.questions.first.examId!;

    ExamsRepository.saveMultiChoiceExamScore(examId: examId, score: ans.grade.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text(
          "Result",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      //
      body: Column(
        children: [
          // result card
          Container(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColor.mainColor,
                      size: 32,
                    ),
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Congratulations! You passed!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
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
                  ],
                ),
                12.height,
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Grade",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          // "99%",
                          "${ans.grade}%",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColor.pinkColor,
                          ),
                        ),
                      ],
                    ),
                    17.width,
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
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: AppColor.scaffoldBg,
                            border: Border.all(color: AppColor.softBorderColor),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          alignment: Alignment.center,
                          // currect ans
                          child: Text(
                            // "6",
                            ans.correctAns.toString(),
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff008000)),
                          ),
                        ),
                        4.height,
                        Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: AppColor.scaffoldBg,
                            border: Border.all(color: AppColor.softBorderColor),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          alignment: Alignment.center,
                          // incurrect ans
                          child: Text(
                            // "1",
                            ans.inCorrectAns.toString(),
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xffFF0000)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                12.height,
                // share btn
                Container(
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
                )
              ],
            ),
          ),
          // answers
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: widget.controller.questions.length,
              itemBuilder: (context, index) {
                final item = widget.controller.questions[index];
                return AnsTile(
                  totalQ: widget.controller.questions.length,
                  currentQ: index + 1,
                  question: item.question!,
                  isCorrect: (item.selectedAnswer == item.correctAnswer),
                  points: int.parse(item.points ?? "0"),
                );
              },
              separatorBuilder: (context, index) => 10.height,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: KBtn(
                height: 44,
                onClick: () {
                  rootNavigator.currentState!.pop();
                },
                text: "Back",
                bgColor: AppColor.white,
                fbColor: Colors.black,
                borderSide: BorderSide(color: AppColor.softBorderColor),
              ),
            ),
            12.width,
            Expanded(
              child: KBtn(
                onClick: () {
                  final reviewPage = MaterialPageRoute(builder: (_) => AsnwerReviewPage(questions: widget.controller.questions));
                  rootNavigator.currentState!.push(reviewPage);
                },
                text: "Next",
                height: 44,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
