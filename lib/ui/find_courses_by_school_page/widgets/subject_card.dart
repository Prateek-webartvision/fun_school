// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/models/courses_dedails/courses.model.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.selectedSubject,
    required this.icon,
    this.onItemSelected,
    this.onEnroll,
    required this.currentItem,
  });

  final IconData icon;
  final CoursesModel currentItem;
  final List<CoursesModel> selectedSubject;

  final Function()? onEnroll;
  final Function()? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93,
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
            child: Icon(icon, color: AppColor.white),
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
                  // name,
                  currentItem.courseName!.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
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
          (!currentItem.isCourseEnrolled)
              ? GestureDetector(
                  onTap: onEnroll,
                  // onTap: () {
                  //   // onEnrollClick!(subjectDetailsPageController.courseData!.isCourseEnrolled);
                  // onEnroll;
                  // },
                  child: Container(
                    height: 40,
                    // width: 48,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(48),
                      border: Border.all(color: AppColor.softBorderColor),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Color(0x0F101828),
                      //     offset: Offset(0, 1),
                      //     blurRadius: 2,
                      //   ),
                      //   BoxShadow(
                      //     color: Color(0x1A101828),
                      //     offset: Offset(0, 1),
                      //     blurRadius: 3,
                      //   ),
                      // ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_rounded,
                          color: AppColor.mainColor,
                          size: 24,
                        ),
                        6.width,
                        Text((currentItem.isCourseEnrolled) ? "Enrolled" : "Enroll")
                      ],
                    ),
                  ),
                )
              // 10.width,
              : GestureDetector(
                  onTap: onItemSelected,
                  child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: (selectedSubject.contains(currentItem)) ? AppColor.pinkColor : null,
                        border: Border.all(color: AppColor.softBorderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child:
                          // (name == (selectedSubject?.courseName ?? ""))
                          // ?
                          Icon(
                        Icons.check,
                        size: 16,
                        color: AppColor.white,
                      )
                      // : 0.height,
                      ),
                ),
        ],
      ),
    );
  }
}
