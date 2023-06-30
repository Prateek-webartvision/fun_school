// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/ui/start_quiz_pages/controller/quiz_controller.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';

class QuizQustionQnswerPage extends StatelessWidget {
  const QuizQustionQnswerPage({super.key});

  popBack2Times() {
    appRoutes.pop();
    appRoutes.pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        popBack2Times();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.scaffoldBg,
            title: Text("Quiz", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            leading: GestureDetector(
              onTap: popBack2Times,
              child: Icon(Icons.arrow_back),
            ),
            centerTitle: true,
          ),
          body: GetBuilder(
            init: Get.find<QuizController>(),
            builder: (controller) {
              return Column(
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
                        LinearProgressIndicator(value: (controller.currentQuizIndex + 1 / controller.quizs!.length), minHeight: 6),
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
                          controller.quizs![controller.currentQuizIndex].question!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  // answer options
                  AnsOptions(
                    seletedAns: controller.quizs![controller.currentQuizIndex].seletedAmswer,
                    options: controller.quizs![controller.currentQuizIndex].answersOptions!,
                    onItemClick: (ans) {
                      controller.setAns(controller.quizs![controller.currentQuizIndex], ans);
                    },
                  )

                  // Expanded(
                  //   child: ListView(
                  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //             width: 107,
                  //             height: 40,
                  //             decoration: BoxDecoration(
                  //               color: AppColor.white,
                  //               border: Border.all(color: AppColor.softBorderColor),
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             alignment: Alignment.center,
                  //             child: Text(
                  //               "70",
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           ),
                  //           Container(
                  //             width: 107,
                  //             height: 40,
                  //             decoration: BoxDecoration(
                  //               color: AppColor.white,
                  //               border: Border.all(color: AppColor.softBorderColor),
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             alignment: Alignment.center,
                  //             child: Text(
                  //               "60",
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           ),
                  //           Container(
                  //             width: 107,
                  //             height: 40,
                  //             decoration: BoxDecoration(
                  //               color: AppColor.white,
                  //               border: Border.all(color: AppColor.softBorderColor),
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             alignment: Alignment.center,
                  //             child: Text(
                  //               "100",
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       //
                  //       28.height,
                  //       // ansBox
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: AppColor.white,
                  //           border: Border.all(color: AppColor.softBorderColor),
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         alignment: Alignment.center,
                  //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //         child: Column(
                  //           children: [
                  //             _AnsTile(text: "One hundred"),
                  //             24.height,
                  //             _AnsTile(text: "Seventy"),
                  //             24.height,
                  //             _AnsTile(text: "Sixty"),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              );
            },
          ),
          //
          bottomNavigationBar: GetBuilder(
            init: Get.find<QuizController>(),
            builder: (controller) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: KBtn(
                        height: 44,
                        onClick: popBack2Times,
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
                        // print("object");
                        if (controller.quizs![controller.currentQuizIndex].seletedAmswer != null) {
                          if ((controller.quizs!.length - 1) > controller.currentQuizIndex) {
                            controller.goToNextQuitions();
                          } else {
                            // time to show result
                            popBack2Times();
                            //todo have to work on result page
                            // appRoutes.pushNamed(PagesName.resultPage);
                            appRoutes.pushNamed(PagesName.quizResultPage, extra: controller.quizs!);
                          }
                        } else {
                          AppUtils.showSnack("Please select your answer first");
                        }
                      },
                      text: "Next",
                      height: 44,
                    )),
                  ],
                ),
              );
            },
          )),
    );
  }
}

class AnsOptions extends StatelessWidget {
  const AnsOptions({
    super.key,
    required this.options,
    required this.onItemClick,
    this.seletedAns,
  });
  final List<String> options;
  final Function(String ans) onItemClick;
  final String? seletedAns;

  @override
  Widget build(BuildContext context) {
    int char = "a".codeUnitAt(0);
    return ListView.separated(
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onItemClick(options[index]),
          child: Container(
            constraints: BoxConstraints(minHeight: 60),
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: (seletedAns == options[index]) ? AppColor.pinkColor : AppColor.softBorderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                text: "${String.fromCharCode(char + index).capitalize}.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: " "),
                  TextSpan(
                    text: options[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // child: Text("${String.fromCharCode(char + index).capitalize}. ${options[index]}"),
          ),
        );
      },
      separatorBuilder: (context, index) => 8.height,
    );
  }
}
