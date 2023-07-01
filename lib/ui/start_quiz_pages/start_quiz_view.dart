// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../router/pages.dart';
import '../../widegts/k_btn.dart';
import 'start_quiz_state.dart';

class StartQuizView extends StatefulWidget {
  const StartQuizView({
    super.key,
    required this.title,
  });
  final String? title;

  @override
  State<StartQuizView> createState() => _StartQuizViewState();
}

class _StartQuizViewState extends StartQuizState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pinkColor,
      appBar: AppBar(
        backgroundColor: AppColor.pinkColor,
        foregroundColor: AppColor.white,
      ),
      body: GetBuilder(
          init: quizController,
          builder: (cnt) {
            return GetBuilder(
              init: mockQuizController,
              builder: (controller) {
                if (controller.apiState == ApiState.loading || cnt.apiState == ApiState.loading) {
                  return Center(child: CircularProgressIndicator(color: AppColor.white));
                } else if (controller.apiState == ApiState.error) {
                  return Center(child: Text(controller.error, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.white)));
                } else {
                  return Column(
                    children: [
                      Container(height: 55),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: Text(
                          "${controller.quizs!.length + cnt.quizs!.length} Question",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ),
                      20.height,
                      Text(
                        "Ready to practice?",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColor.white),
                      ),
                      Text(
                        "Okay. show us what you can do!",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.white),
                      ),
                      // 100.height,
                      Spacer(),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: KBtn(
                          bgColor: AppColor.white,
                          fbColor: Colors.black,
                          height: 44,
                          onClick: () {
                            appRoutes.pushNamed(PagesName.quizQustionAnswerPage, extra: controller);
                          },
                          text: "Start Mock Test (${controller.quizs!.length} Question)",
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: KBtn(
                          bgColor: AppColor.white,
                          fbColor: Colors.black,
                          height: 44,
                          onClick: () {
                            appRoutes.pushNamed(PagesName.quizQustionAnswerPage, extra: cnt);
                          },
                          text: "Start Quiz (${cnt.quizs!.length} Question) ",
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }),
      // bottomNavigationBar: GetBuilder(
      //   init: mockQuizController,
      //   builder: (controller) {
      //     if (controller.apiState != ApiState.success || controller.quizs!.isEmpty) {
      //       return SizedBox();
      //     } else {
      //       return Container(
      //         margin: EdgeInsets.only(bottom: 20),
      //         padding: EdgeInsets.symmetric(horizontal: 16),
      //         child: KBtn(
      //           bgColor: AppColor.white,
      //           fbColor: Colors.black,
      //           height: 44,
      //           onClick: () {
      //             appRoutes.pushNamed(PagesName.quizQustionAnswerPage);
      //           },
      //           text: "Let’s Go ",
      //         ),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
