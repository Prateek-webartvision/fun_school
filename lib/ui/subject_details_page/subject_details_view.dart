// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/find_course_by_career_page/controller/find_course_by_career_controller.dart';
import 'package:citycloud_school/ui/find_course_by_interest_page/controller/find_course_by_interest_controller.dart';
import 'package:citycloud_school/ui/find_courses_by_school_page/controller/find_courses_by_school_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'subject_details_state.dart';
import 'tab_pages/chapter_tab.dart';
import 'widgets/head_title.dart';

class SubjectDetailsView extends StatefulWidget {
  const SubjectDetailsView({super.key, this.courseData});
  final CoursesModel? courseData;

  @override
  State<SubjectDetailsView> createState() => _SubjectDetailsViewState();
}

class _SubjectDetailsViewState extends SubjectDetailsState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: GetBuilder(
        init: (controller is FindCoursesBySchoolController)
            ? controller as FindCoursesBySchoolController
            : (controller is FindCourseByInterestController)
                ? controller as FindCourseByInterestController
                : controller as FindCourseByCareerController,
        builder: (ct) {
          return (widget.courseData == null)
              ? Center(
                  child: Text("Subjects not found"),
                )
              : Column(
                  children: [
                    HeadTitle(
                      title: widget.courseData!.courseName!,
                      controller: pageTabController,
                      tabs: subjects.map((e) => e.subjectName!).toList(),
                      onEnrollClick: onEnrollClick,
                    ),

                    // body
                    Expanded(
                      child: (subjects.isEmpty)
                          ? Container(
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              // color: Colors.green,
                              child: Text("No Subjects found"),
                            )
                          : TabBarView(
                              controller: pageTabController,
                              children: subjects
                                  .asMap()
                                  .map(
                                    (i, value) => MapEntry(
                                      i,
                                      ChaptersTab(
                                        courseID: widget.courseData!.courseId!.toString(),
                                        subject: subjects[i],
                                        enrollmentData: widget.courseData!.courseEnrollment,
                                      ),
                                    ),
                                  )
                                  .values
                                  .toList(),
                            ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
