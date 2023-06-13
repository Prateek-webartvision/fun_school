// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../router/app_router.dart';
import '../../../router/pages.dart';
import '../../../widegts/k_btn.dart';

class StartQuizPage extends StatelessWidget {
  const StartQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pinkColor,
      appBar: AppBar(
        backgroundColor: AppColor.pinkColor,
        foregroundColor: AppColor.white,
      ),
      body: Column(
        children: [
          Container(height: 55),
          Container(
            // height: 24,
            decoration: BoxDecoration(
              // color: AppColor.scaffoldBg,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              "10 Question",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
          18.height,
          Text(
            "Ready to practice?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColor.white),
          ),
          Text(
            "Okay. show us what you can do!",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.white),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: KBtn(
          bgColor: AppColor.white,
          fbColor: Colors.black,
          height: 44,
          onClick: () {
            //
            appRoutes.pushNamed(PagesName.quizQustionAnswerPage);
          },
          text: "Let’s Go ",
        ),
      ),
    );
  }
}
