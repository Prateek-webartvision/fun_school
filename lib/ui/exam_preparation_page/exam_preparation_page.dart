// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../router/pages.dart';
import '../../style/color.dart';
import '../../uitls/app_utils.dart';
import 'widgets/assessment_tile.dart';
import 'widgets/exam_tab_btns.dart';
import 'widgets/exam_tile.dart';

class ExamPreparationPage extends StatefulWidget {
  const ExamPreparationPage({super.key});

  @override
  State<ExamPreparationPage> createState() => _ExamPreparationPageState();
}

class _ExamPreparationPageState extends State<ExamPreparationPage> {
  // late TabController pageTabController;

  @override
  void initState() {
    // pageTabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // pageTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.scaffoldBg,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Examination Hub and btns
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Examination Hub",
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              12.height,
              Container(
                height: 84,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                clipBehavior: Clip.hardEdge,
                child: Row(children: [
                  ExamTabBtns(
                    svgImageIcon: AppAssets.svg.examSearch,
                    title: "Find Exams",
                    onTap: () {},
                  ),
                  ExamTabBtns(
                    svgImageIcon: AppAssets.svg.examStudy,
                    title: "Study Plan",
                  ),
                  ExamTabBtns(
                    svgImageIcon: AppAssets.svg.examAssessment,
                    title: "Assessments",
                  ),
                ]),
              ),
              12.height,
            ],
          ),

          // Popular Exams
          Text(
            "Popular Exams",
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
              ExamTile(
                title: "JAMB",
                color: Color(0xff6519BA),
                onClick: () {
                  appRoutes.pushNamed(PagesName.detailExamPage);
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
                    children: [
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
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       color: AppColor.white,
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Container(height: 16),
      //           Text(
      //             "Exam Preparation",
      //             style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
      //           ),
      //           // 14.height,
      //           TabBar(
      //             controller: pageTabController,
      //             isScrollable: true,
      //             indicatorSize: TabBarIndicatorSize.label,
      //             splashFactory: NoSplash.splashFactory,
      //             overlayColor: MaterialStateProperty.resolveWith<Color?>(
      //               (Set<MaterialState> states) {
      //                 return states.contains(MaterialState.focused) ? null : Colors.transparent;
      //               },
      //             ),
      //             splashBorderRadius: BorderRadius.circular(100),
      //             dividerColor: Colors.transparent,
      //             unselectedLabelColor: AppColor.unSelectedTapColor,
      //             labelPadding: EdgeInsets.only(right: 24),
      //             tabs: const [
      //               Tab(text: "Exam prep"),
      //               Tab(text: "Find an exam"),
      //               Tab(text: "Create exam timetable"),
      //               Tab(text: "My Assessment"),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),

      //     //
      //     Expanded(
      //       child: TabBarView(
      //         controller: pageTabController,
      //         children: [
      //           ExamPrepTab(),
      //           FindAnExamTab(),
      //           Center(child: Text("coming soon")),
      //           Center(child: Text("coming soon")),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
