// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/const.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:citycloud_school/widegts/answer_indicator.dart';
import 'package:citycloud_school/widegts/point_chip.dart';
import 'package:citycloud_school/widegts/question_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../models/exams/exams_models/multi_choice_quetion_model.dart';
import '../../../../style/color.dart';
import '../../../../widegts/k_btn.dart';

part 'controller/answer_review_controller.dart';

class AsnwerReviewPage extends StatefulWidget {
  const AsnwerReviewPage({
    super.key,
    required this.questions,
  });
  final List<MultiChoiceQuestion> questions;

  @override
  State<AsnwerReviewPage> createState() => _AsnwerReviewPageState();
}

class _AsnwerReviewPageState extends State<AsnwerReviewPage> {
  late _AnswerReviewController reviewController;
  @override
  void initState() {
    reviewController = _AnswerReviewController(questions: widget.questions);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        elevation: 1,
        shadowColor: Colors.black,
        title: Text("Detail", style: AppTextStyle.appBarText),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: reviewController,
        builder: (controller) {
          return PageView.builder(
            itemCount: controller.questions.length,
            controller: controller.page,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = controller.questions[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // answer
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    color: (item.correctAnswer == item.selectedAnswer) ? AppColor.green.withOpacity(0.10) : AppColor.red.withOpacity(0.10),
                    child: AnswerIndicator(isCurrect: (item.correctAnswer == item.selectedAnswer)),
                  ),
                  // question
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14).copyWith(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              QuestionChip(totalQuestions: controller.questions.length, currentQuestion: index + 1),
                              PointChip(
                                point: int.parse(item.points ?? "0"),
                              )
                            ],
                          ),
                          12.height,
                          Text(
                            item.question ?? "",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // cureect answer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Answer",
                          style: AppTextStyle.text16W600,
                        ),
                        10.height,
                        Container(
                          padding: EdgeInsets.all(10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            item.correctAnswer ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  14.height,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(2),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        AppUtils.showSnack("Coming soon");
                      },
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        width: double.maxFinite,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.people_rounded, size: 20),
                            6.width,
                            Text(
                              "Discuss with Community",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            6.width,
                            Icon(Icons.arrow_forward_ios_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
      // bottom btns
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: KBtn(
                height: 44,
                onClick: () {
                  reviewController.previous();
                },
                text: "Previous",
                bgColor: AppColor.white,
                fbColor: Colors.black,
                borderSide: BorderSide(color: AppColor.softBorderColor),
              ),
            ),
            12.width,
            Expanded(
              child: KBtn(
                height: 44,
                onClick: () {
                  reviewController.next();
                },
                text: "Next",
                bgColor: AppColor.white,
                fbColor: Colors.black,
                borderSide: BorderSide(color: AppColor.softBorderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
