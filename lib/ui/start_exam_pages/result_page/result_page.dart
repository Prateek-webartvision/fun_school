// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text("Result", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                          "99%",
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
                          child: Text(
                            "6",
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
                          child: Text(
                            "1",
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _AnsTile(isCorrect: true),
                10.height,
                _AnsTile(isCorrect: true),
                10.height,
                _AnsTile(isCorrect: false),
              ],
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
                // appRoutes.pushNamed(PagesName.resultPage);
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

class _AnsTile extends StatelessWidget {
  const _AnsTile({
    super.key,
    required this.isCorrect,
  });
  final bool isCorrect;

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
