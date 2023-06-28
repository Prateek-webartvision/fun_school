// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.name,
    required this.icon,
    // this.selected = false,
    this.onTap,
    this.selectedSubject,
    this.onItemSelected,
  });

  final String name;
  final IconData icon;
  final CoursesModel? selectedSubject;

  final Function()? onTap;
  final Function()? onItemSelected;

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
              backgroundColor: AppColor.mainColor,
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
                    "14 hours . Downloadable",
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
            // Text("${selectedSubject?.courseName ?? "Kundan"}"),
            GestureDetector(
              onTap: onItemSelected,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: (name == (selectedSubject?.courseName ?? "")) ? AppColor.pinkColor : null,
                  border: Border.all(color: AppColor.softBorderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: (name == (selectedSubject?.courseName ?? ""))
                    ? Icon(
                        Icons.check,
                        size: 16,
                        color: AppColor.white,
                      )
                    : 0.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
