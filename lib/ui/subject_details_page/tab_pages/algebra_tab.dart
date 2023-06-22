// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/subject.model.dart';
import '../../../style/color.dart';

class AlgebraTab extends StatelessWidget {
  const AlgebraTab({
    super.key,
    this.subject,
  });
  final CoursesSubject? subject;

  @override
  Widget build(BuildContext context) {
    if (subject!.subjectContent!.isEmpty) {
      return Center(child: Text("No content to show"));
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: subject!.subjectContent!.length,
        itemBuilder: (context, index) {
          final chapter = subject!.subjectContent![index];
          return ChapterTile(
            title: chapter.title!,
            subTitle: chapter.subTitle!,
          );
        },
        separatorBuilder: (context, index) => 12.height,
      );
    }
  }
}

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          //top
          Container(
            height: 44,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      // "Solving equations & inequalities",
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // time
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.textFeildBorderColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "1 hours",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              // children: ,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.play_circle_fill_rounded,
                      color: AppColor.mainColor,
                      size: 20,
                    ),
                    4.width,
                    Text(
                      // "Overview and history algebra",
                      subTitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                //   16.height,
                //   Row(
                //     children: [
                //       Icon(
                //         Icons.play_circle_fill_rounded,
                //         color: AppColor.mainColor,
                //         size: 20,
                //       ),
                //       4.width,
                //       Text(
                //         "Introduction to variables",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //     ],
                //   ),
                //   16.height,
                //   Row(
                //     children: [
                //       Icon(
                //         Icons.play_circle_fill_rounded,
                //         color: AppColor.mainColor,
                //         size: 20,
                //       ),
                //       4.width,
                //       Text(
                //         "Substitution and evaluating expressions",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //     ],
                //   ),
                //   16.height,
                //   Row(
                //     children: [
                //       Icon(
                //         Icons.play_circle_fill_rounded,
                //         color: AppColor.mainColor,
                //         size: 20,
                //       ),
                //       4.width,
                //       Text(
                //         "Combining like terms",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //     ],
                //   ),
                //   16.height,
                //   Row(
                //     children: [
                //       Icon(
                //         Icons.play_circle_fill_rounded,
                //         color: AppColor.mainColor,
                //         size: 20,
                //       ),
                //       4.width,
                //       Text(
                //         "Introduction to equivalent experssions",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //     ],
                //   ),
                //   16.height,
                //   Row(
                //     children: [
                //       Icon(
                //         Icons.play_circle_fill_rounded,
                //         color: AppColor.mainColor,
                //         size: 20,
                //       ),
                //       4.width,
                //       Text(
                //         "Division by zero",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
          10.height,
        ],
      ),
    );
  }
}
