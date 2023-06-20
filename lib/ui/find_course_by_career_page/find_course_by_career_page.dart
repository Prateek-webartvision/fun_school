// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widegts/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../router/pages.dart';

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
                    _TagBtn(title: "Art", selected: true),
                    12.width,
                    _TagBtn(title: "Science"),
                    12.width,
                    _TagBtn(title: "Social Science"),
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
                _SelectIntreset(),
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
                    child: _SubjectCard(name: "English", icon: Icons.group)),
                8.height,
                _SubjectCard(name: "Literature", icon: Icons.book, iconBg: Color(0xffEF6F38)),
                8.height,
                _SubjectCard(name: "Literature", icon: Icons.home_work_rounded, iconBg: AppColor.facebookBlue),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({
    super.key,
    required this.name,
    required this.icon,
    this.onTap,
    this.iconBg,
  });
  final String name;
  final IconData icon;
  final Color? iconBg;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: iconBg ?? AppColor.mainColor,
              child: Icon(
                icon,
                color: AppColor.white,
              ),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "14 hours",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.play_circle_fill_rounded,
                        color: Color(0xff6938EF),
                        size: 18,
                      ),
                      6.width,
                      Text(
                        "Videos",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      13.width,
                      Icon(
                        Icons.info_rounded,
                        color: Color(0xff6938EF),
                        size: 18,
                      ),
                      6.width,
                      Text(
                        "Quizzes",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.width,
            Icon(
              Icons.navigate_next_rounded,
              size: 20,
            ),
            // Checkbox(
            //   value: selected,
            //   fillColor: MaterialStatePropertyAll(AppColor.pinkColor),
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            //   side: BorderSide(
            //     color: AppColor.softBorderColor,
            //     width: 1,
            //   ),
            //   onChanged: (value) {},
            // )
          ],
        ),
      ),
    );
  }
}

//
class _SelectIntreset extends StatelessWidget {
  // const _SelectIntreset({
  //   super.key,
  // });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Interest",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColor.softBorderColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Lawyer, Poet",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              10.width,
              GestureDetector(onTap: () {}, child: Icon(Icons.arrow_drop_down))
            ],
          ),
        ),
      ],
    );
  }
}

//
class _TagBtn extends StatelessWidget {
  const _TagBtn({
    this.selected = false,
    required this.title,
    this.onChanged,
  }) : assert(selected != null);
  final bool? selected;
  final String title;
  final Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onChanged != null) ? () => onChanged!(!selected!) : null,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: (selected == true) ? AppColor.mainColor : AppColor.white,
          border: (selected != true) ? Border.all(color: AppColor.softBorderColor) : null,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: (selected != true) ? Color(0xff192325) : AppColor.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
