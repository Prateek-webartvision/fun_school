// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/exam_certificate_start_pages/question_answer_page/question_answer_page.dart';
import 'package:citycloud_school/widgets/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

class StartExamPage extends StatelessWidget {
  const StartExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        foregroundColor: AppColor.white,
        title: Text("Exam Preparation",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: ListView(
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
                "10 Question",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
          18.height,
          Text(
            "Basic Biology Concepts Summary",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.white),
          ),
          Text(
            "Submit your assignment",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.white),
          ),
          16.height,
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
          // 16.height,
          KBtn(
            bgColor: AppColor.white,
            fbColor: Colors.black,
            height: 44,
            onClick: () {
              //
              // appRoutes.pushNamed(PagesName.questionAnswerPage);
              rootNavigator.currentState!.pushReplacement(
                  MaterialPageRoute(builder: (_) => QuestionAnswerPage()));
            },
            text: "Start",
          ),
          16.height,
          Text(
            "Receive grade",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColor.white),
          ),
          4.height,
          RichText(
            text: TextSpan(
              text: "TO PASS",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white),
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
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColor.white),
          ),
          4.height,
          RichText(
            text: TextSpan(
              text: "_",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white),
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
