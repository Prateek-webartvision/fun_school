// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_find_page/find_exam_page.dart';
import 'package:citycloud_school/widegts/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:kd_utils/methods/timestemp.dart';

import '../../../style/color.dart';
import '../controller/find_exam_crontroller.dart';
import '../widgets/exam_tile.dart';

class FindAnExamTab extends StatefulWidget {
  const FindAnExamTab({
    super.key,
    required this.crontroller,
  });

  final FindExamCrontroller crontroller;

  @override
  State<FindAnExamTab> createState() => _FindAnExamTabState();
}

class _FindAnExamTabState extends State<FindAnExamTab> {
  Future onReload() async {
    await widget.crontroller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: widget.crontroller,
      builder: (cnt) {
        if (cnt.state == ApiState.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (cnt.state == ApiState.error) {
          return ErrorPage(
            error: cnt.error.toString(),
            onError: () {
              cnt.initLoadData();
            },
          );
        }

        return RefreshIndicator(
          onRefresh: onReload,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
            children: [
              // Popular Exams
              if (cnt.populerExams?.isNotEmpty != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popular Exams",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkTextColor,
                      ),
                    ),
                    12.height,
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: cnt.populerExams!.length,
                      itemBuilder: (context, index) {
                        final item = cnt.populerExams![index];
                        final rmColor = AppColor.randomColor;
                        return ExamTile(
                          title: item.examCategoryName.toString(),
                          date: getDateTimeFromTimeStamp(timeStamp: item.dateAdded),
                          color: rmColor,
                          onClick: () {
                            // go to exam sub category page
                            rootNavigator.currentState!.push(
                              MaterialPageRoute(
                                builder: (_) => FindExamPage(
                                  title: item.examCategoryName ?? "N/A",
                                  allExams: item.allExams!,
                                  crontroller: cnt,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => 12.height,
                    ),
                    12.height,
                  ],
                ),

              // Recommended for you
              if (cnt.recommendedExams?.isNotEmpty != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recommended for you",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkTextColor,
                      ),
                    ),
                    12.height,
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: cnt.recommendedExams!.length,
                      itemBuilder: (context, index) {
                        final item = cnt.recommendedExams![index];
                        final rmColor = AppColor.randomColor;
                        return ExamTile(
                          title: item.examCategoryName.toString(),
                          date: getDateTimeFromTimeStamp(timeStamp: item.dateAdded),
                          color: rmColor,
                          onClick: () {
                            // go to exam sub category page
                            rootNavigator.currentState!.push(
                              MaterialPageRoute(
                                builder: (_) => FindExamPage(
                                  title: item.examCategoryName ?? "N/A",
                                  crontroller: cnt,
                                  allExams: item.allExams!,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => 12.height,
                    ),
                    12.height,
                  ],
                ),

              // // Personalized Study Plans
              // Text(
              //   "Personalized Study Plans",
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //     color: AppColor.darkTextColor,
              //   ),
              // ),
              // 12.height,
              // Container(
              //   height: 153,
              //   width: double.maxFinite,
              //   decoration: BoxDecoration(
              //     color: AppColor.white,
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   clipBehavior: Clip.hardEdge,
              //   padding: EdgeInsets.all(12),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         height: 40,
              //         width: 40,
              //         decoration: BoxDecoration(
              //           color: AppColor.mainColor,
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //         alignment: Alignment.center,
              //         child: SvgPicture.asset(AppAssets.svg.examStudyPlanIcon),
              //       ),
              //       10.height,
              //       Text(
              //         "Physics Mock 2023",
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //       Text(
              //         "Date : September 12, 2023",
              //         style: TextStyle(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       Text.rich(
              //         TextSpan(
              //           text: "Study Hours: 20 hours (",
              //           children: const [
              //             TextSpan(text: "40 % completed", style: TextStyle(color: AppColor.mainColor)),
              //             TextSpan(text: ")"),
              //           ],
              //         ),
              //         style: TextStyle(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       Text(
              //         "Next Session: Tomorrow, 4:30 pm",
              //         style: TextStyle(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // 12.height,
              // //
              // Text(
              //   "Recent Assessments",
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // 12.height,
              // ListView(
              //   shrinkWrap: true,
              //   primary: false,
              //   children: [
              //     AssessmentTile(
              //       title: "JAMB Mock 2023",
              //       score: 75,
              //       sipStatus: "3 weak areas identified",
              //     ),
              //     8.height,
              //     AssessmentTile(
              //       title: "SSCE Practice, 2022",
              //       score: 68,
              //       sipStatus: "2 weak areas identified",
              //     ),
              //   ],
              // )
            ],
          ),
        );
      },
    );
  }
}
