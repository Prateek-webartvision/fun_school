// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/theme.dart';

class MockSubjectTile extends StatelessWidget {
  const MockSubjectTile({
    super.key,
    required this.title,
    this.onClick,
    this.multiChoiceQuestions = 0,
    this.theoryQuestions = 0,
  });
  final String title;
  // final int questions;
  final int multiChoiceQuestions;
  final int theoryQuestions;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: AppShadow.boxShadow,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                // Text(
                //   "30 minutes",
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColor.mainColor),
                // )
              ],
            ),
            Text(
              // "$questions questions",
              "$multiChoiceQuestions Multichoice Questions • $theoryQuestions Theory Questions",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
