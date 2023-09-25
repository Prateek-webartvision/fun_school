// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/style/const.dart';
import 'package:citycloud_school/ui/exam_assessment_details_page/exam_assessment_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';

class ExamMyAssessmentsPage extends StatefulWidget {
  const ExamMyAssessmentsPage({super.key});

  @override
  State<ExamMyAssessmentsPage> createState() => _ExamMyAssessmentsPageState();
}

class _ExamMyAssessmentsPageState extends State<ExamMyAssessmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('My Assessments'),
      //   titleTextStyle: AppTextStyle.appBarText,
      //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add_rounded))],
      // ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          // message
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Assessments",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              4.height,
              Text(
                "Review scores and analyses to hone strengths and address weaknesses.",
                style: TextStyle(fontSize: 14),
              ),
              12.height,
            ],
          ),
          // assessment
          ListView(
            shrinkWrap: true,
            children: [
              AssessmentItemTile(
                title: "Mathematics Mid-Term 2023",
                date: DateTime(2023, 3, 15),
                score: 85,
                scoreOutoff: 100,
                onClick: () {
                  rootNavigator.currentState!.push(MaterialPageRoute(
                    builder: (context) => ExamAssessmentDetailsPage(),
                  ));
                },
              ),
              12.height,
              AssessmentItemTile(
                title: "English Literature Quiz - Poetry Section",
                date: DateTime(2023, 4, 4),
                score: 40,
                scoreOutoff: 50,
              ),
              12.height,
              AssessmentItemTile(
                title: "Physics Practical Exam",
                date: DateTime(2023, 4, 28),
                score: 45,
                scoreOutoff: 60,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AssessmentItemTile extends StatelessWidget {
  const AssessmentItemTile({
    super.key,
    required this.title,
    required this.date,
    required this.score,
    required this.scoreOutoff,
    this.onClick,
  });
  final String title;
  final DateTime date;
  final int score;
  final int scoreOutoff;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(color: AppColor.white),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.text16W600,
            ),
            Text(
              // "Date Taken: March 15, 2023",
              "Date Taken: ${DateFormat("MMMM d, yyyy").format(date)}",
              style: AppTextStyle.text12W400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(text: "Score: ", children: [
                    TextSpan(
                      text: "$score/$scoreOutoff",
                      style: TextStyle(color: AppColor.mainColor),
                    ),
                  ]),
                  style: AppTextStyle.text12W400,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
