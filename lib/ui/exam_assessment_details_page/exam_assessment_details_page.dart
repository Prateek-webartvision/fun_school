// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/style/const.dart';
import 'package:citycloud_school/style/theme.dart';
import 'package:citycloud_school/ui/exam_assessment_analysis_page/exam_assessment_analysis_page.dart';
import 'package:citycloud_school/widgets/k_btn.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import 'widgets/pie_color_box.dart';
import 'widgets/strenght_tile.dart';

class ExamAssessmentDetailsPage extends StatefulWidget {
  const ExamAssessmentDetailsPage({super.key});

  @override
  State<ExamAssessmentDetailsPage> createState() =>
      _ExamAssessmentDetailsPageState();
}

class _ExamAssessmentDetailsPageState extends State<ExamAssessmentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mathematics Mid-Term 2023"),
        titleTextStyle: AppTextStyle.appBarText,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
        // shadowColor: AppColor.softBorderColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadow.boxShadow,
            ),
            width: double.maxFinite,
            padding: EdgeInsets.all(12).copyWith(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mathematics Mid-Term 2023",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                6.height,
                Text.rich(
                  TextSpan(
                    text: "Score: ",
                    children: [
                      TextSpan(
                          text: "85/100",
                          style: TextStyle(color: AppColor.mainColor)),
                    ],
                    style: AppTextStyle.text12W400,
                  ),
                ),
                6.height,
                // pie
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // pie chart
                      SizedBox(
                        height: 81,
                        width: 81,
                        child: PieChart(
                          PieChartData(
                            // read about it in the PieChartData section
                            sections: [
                              PieChartSectionData(
                                color: AppColor.mainColor,
                                value: 85 / 100,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                color: AppColor.pinkColor,
                                value: 15 / 100,
                                showTitle: false,
                              ),
                            ],
                            centerSpaceRadius: 1,
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            pieTouchData: PieTouchData(enabled: false),
                          ),

                          swapAnimationDuration:
                              Duration(milliseconds: 150), // Optional
                          swapAnimationCurve: Curves.linear, // Optional
                        ),
                      ),
                      12.height,
                      // color data
                      Row(
                        children: [
                          PieColorBox(
                            boxColor: AppColor.mainColor,
                            text: "Correct Answers",
                          ),
                          8.width,
                          PieColorBox(
                            boxColor: AppColor.pinkColor,
                            text: "Wrong Answers",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //
          12.height,
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadow.boxShadow,
            ),
            width: double.maxFinite,
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Strengths",
                  style: AppTextStyle.text12W400,
                ),
                5.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // spacing: 13.5,
                  // alignment: WrapAlignment.center,
                  children: [
                    StrengthsTile(
                      text: "Algebra",
                      score: 95,
                      scoreColor: AppColor.green,
                    ),
                    StrengthsTile(
                      text: "Geometry",
                      score: 80,
                      scoreColor: AppColor.mainColor,
                    ),
                    StrengthsTile(
                      text: "Trigonometry",
                      score: 70,
                      scoreColor: AppColor.red,
                    ),
                  ],
                )
              ],
            ),
          ),

          // Areas for Improvement
          12.height,
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadow.boxShadow,
            ),
            width: double.maxFinite,
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Areas for Improvement",
                  style: AppTextStyle.text12W400,
                ),
                5.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // spacing: 13.5,
                  // alignment: WrapAlignment.center,
                  children: [
                    Expanded(
                      child: StrengthsTile(
                        text: "Calculus",
                        score: 50,
                      ),
                    ),
                    8.width,
                    Expanded(
                      child: StrengthsTile(
                        text: "Statistics",
                        score: 55,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          //
          12.height,
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadow.boxShadow,
            ),
            width: double.maxFinite,
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question-by-Question Analysis",
                  style: AppTextStyle.text12W400,
                ),
                12.height,
                Container(
                  height: 74,
                  decoration: BoxDecoration(
                    // color: AppColor.scaffoldBg,
                    image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      image: AssetImage("assets/img/q_analysis.png"),
                    ),
                  ),
                ),
                12.height,
                Text(
                  "Link to Topic: Calculus Section - www.mathstudy.com/calculus",
                  style: AppTextStyle.text12W400,
                ),
                12.height,
                KBtn(
                  width: double.maxFinite,
                  height: 44,
                  bgColor: AppColor.white,
                  fbColor: Colors.black,
                  borderSide: BorderSide(color: AppColor.softBorderColor),
                  onClick: () {
                    rootNavigator.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => ExamAssessmentAnalysisPage(),
                      ),
                    );
                  },
                  text: "View Question Analysis",
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        // alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: KBtn(
          width: double.maxFinite,
          height: 44,
          onClick: () {},
          text: "Share",
        ),
      ),
    );
  }
}
