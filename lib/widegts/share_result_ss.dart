// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../style/color.dart';

class ShareResultSS extends StatelessWidget {
  const ShareResultSS({super.key, required this.ans});
  final ({int correctAns, int grade, int inCorrectAns}) ans;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Fun School"),
            10.height,
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
                      (ans.grade >= 75) ? "Congratulations! You passed!" : "Try again",
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
                      // "99%",
                      "${ans.grade}%",
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
                  mainAxisSize: MainAxisSize.min,
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
                      // currect ans
                      child: Text(
                        // "6",
                        ans.correctAns.toString(),
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
                      // incurrect ans
                      child: Text(
                        // "1",
                        ans.inCorrectAns.toString(),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xffFF0000)),
                      ),
                    ),
                  ],
                )
              ],
            ),
            // 12.height,
          ],
        ),
      ),
    );
  }
}
