// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';

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
      body: (widget.courseData == null)
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
                                    subject: subjects[i],
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        ),
                ),
              ],
            ),
    );
  }
}
