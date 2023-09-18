// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_find_page/find_exam_page.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/assets.dart';
import '../../../style/color.dart';
import '../widgets/assessment_tile.dart';
import '../widgets/exam_tile.dart';

class FindAnExamTab extends StatelessWidget {
  const FindAnExamTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      children: [
        // Popular Exams
        Text(
          "Popular Exams",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.darkTextColor,
          ),
        ),
        12.height,
        ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            ExamTile(
              title: "JAMB",
              color: Color(0xff6519BA),
              onClick: () {
                // AppUtils.showSnack("coming soon");
                rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => FindExamPage()));
              },
            ),
            12.height,
            ExamTile(
                title: "WAEC",
                color: Color(0xffEF6F38),
                onClick: () {
                  AppUtils.showSnack("coming soon");
                }),
            12.height,
            ExamTile(
                title: "SSCE",
                color: Color(0xff3897EF),
                onClick: () {
                  AppUtils.showSnack("coming soon");
                }),
          ],
        ),
        12.height,

        // Personalized Study Plans
        Text(
          "Personalized Study Plans",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.darkTextColor,
          ),
        ),
        12.height,
        Container(
          height: 153,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(AppAssets.svg.examStudyPlanIcon),
              ),
              10.height,
              Text(
                "Physics Mock 2023",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Date : September 12, 2023",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text.rich(
                TextSpan(
                  text: "Study Hours: 20 hours (",
                  children: const [
                    TextSpan(text: "40 % completed", style: TextStyle(color: AppColor.mainColor)),
                    TextSpan(text: ")"),
                  ],
                ),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Next Session: Tomorrow, 4:30 pm",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        12.height,
        //
        Text(
          "Recent Assessments",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        12.height,
        ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            AssessmentTile(
              title: "JAMB Mock 2023",
              score: 75,
              sipStatus: "3 weak areas identified",
            ),
            8.height,
            AssessmentTile(
              title: "SSCE Practice, 2022",
              score: 68,
              sipStatus: "2 weak areas identified",
            ),
          ],
        )
      ],
    );
  }
}
