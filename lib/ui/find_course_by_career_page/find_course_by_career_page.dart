// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widegts/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../router/pages.dart';
import 'widgets/select_intreset.dart';
import 'widgets/subject_card.dart';
import 'widgets/teg_selector.dart';

class FindCourseByCareerPage extends StatelessWidget {
  const FindCourseByCareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text(
          "Courses by Career",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //head
          Container(
            height: 126,
            decoration: BoxDecoration(
              color: AppColor.white,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                KSearchField(),
                12.height,
                Row(
                  children: [
                    TagSelector(title: "Art", selected: true),
                    12.width,
                    TagSelector(title: "Science"),
                    12.width,
                    TagSelector(title: "Social Science"),
                  ],
                ),
              ],
            ),
          ),
          //list
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                SelectIntreset(),
                12.height,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "School Level",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Junior secondary school",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        6.width,
                        GestureDetector(onTap: () {}, child: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                  ],
                ),
                12.height,
                GestureDetector(
                    onTap: () {
                      appRoutes.pushNamed(PagesName.coursesBySchoolDetailsPage);
                    },
                    child: SubjectCard(name: "English", icon: Icons.group)),
                8.height,
                SubjectCard(name: "Literature", icon: Icons.book, iconBg: Color(0xffEF6F38)),
                8.height,
                SubjectCard(name: "Literature", icon: Icons.home_work_rounded, iconBg: AppColor.facebookBlue),
              ],
            ),
          )
        ],
      ),
    );
  }
}
