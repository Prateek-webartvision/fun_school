// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/exam_find_page/find_exam_page.dart';
import 'package:citycloud_school/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../controller/find_exam_controller.dart';
import '../widgets/exam_tile.dart';

class FindAnExamTab extends StatefulWidget {
  const FindAnExamTab({
    super.key,
    required this.controller,
  });

  final FindExamController controller;

  @override
  State<FindAnExamTab> createState() => _FindAnExamTabState();
}

class _FindAnExamTabState extends State<FindAnExamTab> {
  Future onReload() async {
    await widget.controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: widget.controller,
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
              if (cnt.popPulerExams?.isNotEmpty != null)
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
                      itemCount: cnt.popPulerExams!.length,
                      itemBuilder: (context, index) {
                        final item = cnt.popPulerExams![index];
                        final rmColor = AppColor.randomColor;

                        return ExamTile(
                          title: item.examCategoryName.toString(),
                          date: getDateTimeFromTimeStamp(
                              timeStamp: item.dateAdded),
                          color: rmColor,
                          onClick: () {
                            // go to exam sub category page
                            rootNavigator.currentState!.push(
                              MaterialPageRoute(
                                builder: (_) => FindExamPage(
                                  title: item.examCategoryName ?? "N/A",
                                  allExams: item.allExams!,
                                  controller: cnt,
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
                          date: getDateTimeFromTimeStamp(
                              timeStamp: item.dateAdded),
                          color: rmColor,
                          onClick: () {
                            //* go to exam sub category page
                            rootNavigator.currentState!.push(
                              MaterialPageRoute(
                                builder: (_) => FindExamPage(
                                  title: item.examCategoryName ?? "N/A",
                                  controller: cnt,
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
            ],
          ),
        );
      },
    );
  }
}
