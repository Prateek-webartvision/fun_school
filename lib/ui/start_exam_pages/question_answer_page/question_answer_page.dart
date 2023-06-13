// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../widegts/k_btn.dart';

class QuestionAnswerPage extends StatefulWidget {
  const QuestionAnswerPage({super.key});

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  List<String> questions = [
    "A name that refers to a value",
    "A name that refers to a literal",
    "A programming-language representation of a value",
    "A statement that associates a variable with a type",
    "None of the above"
  ];
  String? seletedAns;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text("Exam Preparation", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
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
                LinearProgressIndicator(
                  value: (1 / 7),
                  minHeight: 6,
                ),
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
                        "Question 1/7",
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
                  "Of the following, which best describes a variable?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          // answer card

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: (seletedAns == questions[index]) ? Border.all(color: AppColor.pinkColor) : null,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.only(right: 16, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Radio<String?>(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: AppColor.pinkColor,
                        value: seletedAns,
                        groupValue: questions[index],
                        onChanged: (value) {
                          setState(() {
                            seletedAns = questions[index];
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          questions[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                onClick: () {},
                text: "Let’s Go",
                bgColor: AppColor.white,
                fbColor: Colors.black,
                borderSide: BorderSide(color: AppColor.softBorderColor),
              ),
            ),
            12.width,
            Expanded(
                child: KBtn(
              onClick: () {
                appRoutes.pushNamed(PagesName.resultPage);
              },
              text: "Next",
              height: 44,
            )),
          ],
        ),
      ),
    );
  }
}
