// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/const.dart';
import 'package:citycloud_school/ui/exam_find_start_mock_page/submit_page/submit_pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../widegts/k_btn.dart';

class ExamFindStartMockPage extends StatefulWidget {
  const ExamFindStartMockPage({super.key});

  @override
  State<ExamFindStartMockPage> createState() => _ExamFindStartMockPageState();
}

class _ExamFindStartMockPageState extends State<ExamFindStartMockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          AppAssets.startExamTextBg,
          height: context.screenHeight,
          width: context.screenWidth,
          fit: BoxFit.cover,
        ),
        // Color
        Container(
          height: context.screenHeight,
          width: context.screenWidth,
          decoration: BoxDecoration(color: AppColor.mainColor.withOpacity(0.7)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            AppAssets.startExamQBg,
            fit: BoxFit.cover,
          ),
        ),

        // body
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColor.white,
            titleTextStyle: AppTextStyle.appBarText.copyWith(color: AppColor.white),
            title: Text("Exam Preparation"),
            centerTitle: true,
          ),
          //
          body: Stack(
            children: [
              // body
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  53.height,
                  Center(
                    child: Container(
                      // height: 24,
                      decoration: BoxDecoration(
                        // color: AppColor.scaffoldBg,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        "1 Question",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                  ),
                  18.height,
                  Text(
                    "Mathematics",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColor.white),
                  ),
                  Text(
                    "45 minutes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.white),
                  ),
                  // 16.height,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Due",
                  //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColor.white),
                  //     ),
                  //     Text(
                  //       ". Oct 29, 2:59 PM GMT+8",
                  //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.white),
                  //     ),
                  //   ],
                  // ),

                  // 16.height,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Attemps",
                  //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColor.white),
                  //     ),
                  //     Text(
                  //       ". 3 every 8 hours",
                  //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.white),
                  //     ),
                  //   ],
                  // ),
                  16.height,
                  KBtn(
                    bgColor: AppColor.white,
                    fbColor: Colors.black,
                    height: 44,
                    onClick: () {
                      //
                      // appRoutes.pushNamed(PagesName.questionAnswerPage);
                      rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => MockSubmitPdfPage()));
                    },
                    text: "Start",
                  ),
                  16.height,
                  Text(
                    "Receive grade",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColor.white),
                  ),
                  4.height,
                  RichText(
                    text: TextSpan(
                      text: "TO PASS",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.white),
                      children: [
                        TextSpan(text: " "),
                        TextSpan(
                          text: "75% or higher",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  Text(
                    "Grad",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColor.white),
                  ),
                  4.height,
                  RichText(
                    text: TextSpan(
                      text: "_",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.white),
                      children: [],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
