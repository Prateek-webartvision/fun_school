// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../repo/quiz_repo/quiz_repo.dart';
import '../../../../router/app_router.dart';
import '../../../../router/pages.dart';
import '../../../../style/color.dart';
import '../../../../widegts/k_btn.dart';
import '../../controller/quiz_controller.dart';
import '../../model/quiz_model.dart';

class QuizTabPage extends StatelessWidget {
  const QuizTabPage({
    super.key,
    required this.quizController,
    required this.courseID,
  });
  final QuizController quizController;
  final String courseID;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: quizController,
      builder: (controller) {
        var quiz = controller.quizs![controller.currentQuizIndex];
        return Scaffold(
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.softBorderColor),
                  // borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // bar
                    LinearProgressIndicator(value: (controller.currentQuizIndex + 1) / controller.quizs!.length, minHeight: 6),
                    14.height,
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
                            "Question ${controller.currentQuizIndex + 1}/${controller.quizs!.length}",
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

                    // qustion
                    Text(
                      // "Look at the numbers. Drag and drop in their correct word.",
                      quiz.questionTitle!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),

              // dag options
              20.height,

              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: quiz.quizData!
                    .map(
                      (e) => Draggable<QuizData>(
                        data: e,
                        feedback: DragableTitle(
                          ans: e.correctAnswer!,
                        ),
                        // childWhenDragging: SizedBox(),
                        child: DragableTitle(
                          ans: e.correctAnswer!,
                        ),
                      ),
                    )
                    .toList(),
              ),
              20.height,
              // target
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.softBorderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: quiz.quizData!.length,
                  itemBuilder: (context, index) {
                    return DragTarget<QuizData>(
                      onAccept: (data) {
                        controller.changeAns(quizDataIndex: index, selectedAns: data.correctAnswer!);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          height: 40,
                          // color: Colors.green,
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                text: quiz.quizData![index].question,
                                style: TextStyle(color: Colors.black),
                                children: (quiz.quizData![index].selectedAns != null)
                                    ? [
                                        TextSpan(text: " "),
                                        TextSpan(text: quiz.quizData![index].selectedAns!),
                                      ]
                                    : [
                                        TextSpan(text: " "),
                                        TextSpan(text: "_________"),
                                      ]),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 0.height;
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: GetBuilder(
            init: quizController,
            builder: (controller) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: KBtn(
                        height: 44,
                        onClick: () {
                          appRoutes.pop();
                          appRoutes.pop();
                        },
                        text: "Cancel",
                        bgColor: AppColor.white,
                        fbColor: Colors.black,
                        borderSide: BorderSide(color: AppColor.softBorderColor),
                      ),
                    ),
                    12.width,
                    Expanded(
                        child: KBtn(
                      onClick: () {
                        // check all answers are given
                        var d = controller.quizs![controller.currentQuizIndex].quizData!.where((element) => element.selectedAns == null).toList();
                        if (d.isNotEmpty) {
                          AppUtils.showSnack("Fill All answers");
                        } else if ((controller.quizs!.length - 1) > controller.currentQuizIndex) {
                          controller.goToNextQuitions();
                        } else {
                          appRoutes.pop();
                          appRoutes.pop();
                          // final data = {"type": QuizType.quiz, "data": controller.quizs};
                          final data = {
                            "type": QuizType.quiz,
                            "data": controller.quizs!,
                            "courseId": courseID,
                          };
                          appRoutes.pushNamed(PagesName.quizResultPage, extra: data);
                        }
                      },
                      text: "Next",
                      height: 44,
                    )),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class DragableTitle extends StatelessWidget {
  const DragableTitle({
    super.key,
    required this.ans,
  });
  final String ans;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 107,
        height: 40,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          // "100",
          ans,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
