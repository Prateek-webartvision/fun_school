// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';

class QuizQustionQnswerPage extends StatelessWidget {
  const QuizQustionQnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text("Quiz", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                LinearProgressIndicator(value: (1 / 10), minHeight: 6),
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
                        "Question 1/10",
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
                  "Look at the numbers. Drag and drop in their correct word.",
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
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 107,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.softBorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "70",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: 107,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.softBorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "60",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: 107,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.softBorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "100",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                //
                28.height,
                // ansBox
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(color: AppColor.softBorderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      _AnsTile(text: "One hundred"),
                      24.height,
                      _AnsTile(text: "Seventy"),
                      24.height,
                      _AnsTile(text: "Sixty"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      //
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: KBtn(
                height: 44,
                onClick: () {},
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
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        4.width,
        Container(
          width: 100,
          height: 24,
          decoration: BoxDecoration(
            // color: Colors.green,
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1.5),
            ),
          ),
        )
      ],
    );
  }
}
